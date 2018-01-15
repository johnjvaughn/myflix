require "spec_helper"

feature "User interacts with queue" do
  scenario "user adds and reorders videos in the queue" do
    comedies = Fabricate(:category)
    monk = Fabricate(:video, title: "Monk", category: comedies)
    sp = Fabricate(:video, title: "South Park", category: comedies)
    fut = Fabricate(:video, title: "Futurama", category: comedies)

    sign_in

    add_video_to_queue(monk)
    expect_to_see_text(monk.title)

    visit video_path(monk)
    expect_to_not_see_text("+ My Queue")

    add_video_to_queue(sp)
    add_video_to_queue(fut)

    set_video_sort_order(monk, 3)
    set_video_sort_order(sp, 1)
    set_video_sort_order(fut, 2)

    submit_queue_update
    
    expect_video_sort_order(sp, 1)
    expect_video_sort_order(fut, 2)
    expect_video_sort_order(monk, 3)
  end
end

def submit_queue_update
  click_button "Update Instant Queue"
end

def expect_to_see_text(text)
  expect(page).to have_content(text)
end
def expect_to_not_see_text(text)
  expect(page).to have_no_content(text)
end

def add_video_to_queue(video)
  visit home_path
  find("a[href='/videos/#{video.id}']").click
  click_link "+ My Queue"
end

def set_video_sort_order(video, sort_order)
  find("input[data-video-id='#{video.id}']").set(sort_order)
end

def expect_video_sort_order(video, sort_order)
  expect(find("input[data-video-id='#{video.id}']").value).to eq(sort_order.to_s)
end
