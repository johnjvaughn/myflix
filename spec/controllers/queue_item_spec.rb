require "spec_helper"

describe QueueItemsController do
  describe "GET index" do
    context "authenticated user" do
      let(:current_user) { Fabricate(:user) }
      let(:other_user) { Fabricate(:user) }
      let(:videos) { [ Fabricate(:video), Fabricate(:video) ] }
      let(:current_queue) {
        [ 
          Fabricate(:queue_item, user_id: current_user.id, video_id: videos[0].id),
          Fabricate(:queue_item, user_id: current_user.id, video_id: videos[1].id)
        ]
      }
      let(:other_queue_item) { QueueItem.create(user_id: other_user.id, video_id: videos[0].id, sort_order: 1) }
      before do
        session[:user_id] = current_user.id
        get :index
      end

      it "renders index page" do
        expect(response).to render_template(:index)
      end
      it "sets @queue_items" do
        expect(assigns(:queue_items)).to match_array(current_queue)
      end
    end

    context "inauthenticated user" do
      before do
        session[:user_id] = nil
        get :index
      end
      it "redirects to sign_in page" do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "POST create" do
    context "authenticated user with valid new queue item" do
      let(:user) { Fabricate(:user) }
      let(:videos) { [Fabricate(:video), Fabricate(:video)] }
      before do
        session[:user_id] = user.id
        Fabricate(:queue_item, user: user, video: videos[0])
        post :create, params: { video_id: videos[1].id } 
      end
      it "creates a new queue item for the user" do
        expect(user.queue_items.count).to eq(2)
      end
      it "adds new queue item to end of existing queue with proper associations" do
        qi = QueueItem.find_by(user: user, video: videos[1], sort_order: 2)
        expect(qi).to_not be_nil
      end
      it "redirects to the my_queue page" do
        expect(response).to redirect_to(queue_items_path)
      end
      it "sets a notice" do
        expect(flash[:notice]).to_not be_blank
      end
    end
    context "authenticated user with duplicate queue item" do
      let(:user) { Fabricate(:user) }
      let(:videos) { [Fabricate(:video), Fabricate(:video)] }
      before do
        session[:user_id] = user.id
        Fabricate(:queue_item, user: user, video: videos[0])
        post :create, params: { video_id: videos[0].id } 
      end
      it "does not create a new queue item for the user" do
        expect(user.queue_items.count).to eq(1)
      end
    end
    context "inauthenticated user" do
      before do
        video = Fabricate(:video)
        session[:user_id] = nil
        post :create, params: { video_id: video.id } 
      end
      it "redirects to sign_in page" do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "POST destroy" do
    context "authenticated user" do
      let(:user) { Fabricate(:user) }
      let(:videos) { [Fabricate(:video), Fabricate(:video)] }
      let(:qis) { [Fabricate(:queue_item, user: user, video: videos[0]),
                   Fabricate(:queue_item, user: user, video: videos[1])] }
      before do
        session[:user_id] = user.id
      end
      it "deletes the appropriate queue item for the user" do
        delete :destroy, params: { id: qis[0].id } 
        qis[1].sort_order = 1
        expect(user.queue_items).to eq([qis[1]])
      end
      it "does not delete if queue item is not owned by user" do
        other_user = Fabricate(:user)
        qis.each{|qi| qi.save}
        other_qi = Fabricate(:queue_item, user: other_user, video: videos[0])
        delete :destroy, params: { id: other_qi.id } 
        expect(QueueItem.count).to eq(3)
      end
      it "redirects to the queue page" do
        delete :destroy, params: { id: qis[0].id } 
        expect(response).to redirect_to(queue_items_path)
      end
    end

    context "inauthenticated user" do
      before do
        user = Fabricate(:user)
        videos = [Fabricate(:video), Fabricate(:video)]
        qis = [Fabricate(:queue_item, user: user, video: videos[0]),
               Fabricate(:queue_item, user: user, video: videos[1])]
        session[:user_id] = nil
        delete :destroy, params: { id: qis[0].id } 
      end
      it "does not delete queue item" do
        expect(QueueItem.count).to eq(2)
      end
      it "redirects to sign_in page" do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "PUT update_queue" do
    context "authenticated user" do
      let(:user) { Fabricate(:user) }
      let(:videos) { [Fabricate(:video), Fabricate(:video)] }
      let(:qis) { [QueueItem.create(sort_order: 18, user: user, video: videos[0]),
                   QueueItem.create(sort_order: 15, user: user, video: videos[1])] }
      before do
        session[:user_id] = user.id
      end
      context "valid data" do
        it "changes queue item sort order correctly" do
          put :update_queue, params: { queue_items: 
            [{id: "#{qis[0].id}", sort_order: "3"}, 
             {id: "#{qis[1].id}", sort_order: "2"}] }
          qis.each {|q| q.reload }
          expect(qis[0].sort_order).to eq(2)
          expect(qis[1].sort_order).to eq(1)
        end
      end
      context "invalid data" do
        it "will not change sort order of queue items user does not own" do
          user2 = Fabricate(:user)
          other_qi = QueueItem.create(sort_order: 7, user: user2, video: videos[0])
          put :update_queue, params: { 
            queue_items: [{id: "#{other_qi.id}", sort_order: "3"}] }
          other_qi.reload
          expect(other_qi.sort_order).to eq(7)
        end
      end
    end
    context "inauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:videos) { [Fabricate(:video), Fabricate(:video)] }
      let(:qis) { [QueueItem.create(sort_order: 18, user: user, video: videos[0]),
                   QueueItem.create(sort_order: 15, user: user, video: videos[1])] }
      before do
        session[:user_id] = nil
        # put :update_queue, params: {queue_sort_order: {"#{qis[0].id}": 3, "#{qis[1].id}": 2}}
        put :update_queue, params: { queue_items: 
            [{id: "#{qis[0].id}", sort_order: "3"}, 
             {id: "#{qis[1].id}", sort_order: "2"}] }
      end
      it "does not update any queue items" do
        qis.each{ |q| q.reload }
        expect(qis[0].sort_order).to eq(18)
        expect(qis[1].sort_order).to eq(15)
      end
      it "redirects to sign_in page" do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

end