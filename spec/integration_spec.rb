require('capybara/rspec')
  require('./app')
  Capybara.app = Sinatra::Application
  set(:show_exceptions, false)

  #Intergration test to add a new list.
  describe('adding a new list', {:type => :feature}) do
    it('allows a user to click a list to see the tasks and details for it') do
      visit('/')
      click_link('Add New List')
      fill_in('name', :with =>'Moringaschool Work')
      click_button('Add List')
      expect(page).to have_content('Success!')
    end
  end

  #intergration test to show all the lists.
  describe('viewing all of the lists', {:type => :feature}) do
    it('allows a user to see all of the lists that have been created') do
      list = List.new({:name => 'Moringaschool Homework',:id=>nil})
      list.save()
      visit('/')
      click_link('View All Lists')
      expect(page).to have_content(list.name)
    end
  end

  #intergration test to see task details for a single list.
  describe('seeing details for a single list', {:type => :feature}) do
    it('allows a user to click a list to see the tasks and details for it') do
      test_list = List.new({:name => 'School stuff',:id=>nil})
      test_list.save()
      test_task = Task.new({:description => "learn SQL", :list_id => test_list.id()})
      test_task.save()
      visit('/lists')
      click_link(test_list.name())
      expect(page).to have_content(test_task.description())
    end
  end

  #interration test to add tasks to a list.
  describe('adding tasks to a list', {:type => :feature}) do
    it('allows a user to add a task to a list') do
      test_list = List.new({:name => 'School stuff',:id=>nil})
      test_list.save()
      visit("/lists/#{test_list.id()}")
      fill_in("Description", {:with => "Learn SQL"})
      click_button("Add task")
      expect(page).to have_content("Success")
    end
  end
