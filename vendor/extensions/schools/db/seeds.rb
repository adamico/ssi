if defined?(::Refinery::User)
  ::Refinery::User.all.each do |user|
    if user.plugins.where(:name => 'refinerycms-schools').blank?
      user.plugins.create(:name => 'refinerycms-schools',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end


index_url = "/previous"
if defined?(::Refinery::Page) && ::Refinery::Page.where(:link_url => index_url).empty?
  index_page = ::Refinery::Page.create(
    :title => 'Previous Schools',
    :link_url => index_url,
    :deletable => false,
    :menu_match => "^#{index_url}(\/|\/.+?|)$"
  )
  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
    index_page.parts.create(:title => default_page_part, :body => nil, :position => index)
  end
  index_page.parts.first.body = "<p>The contents of previous Summerschools have been published as special issues of<em> Journal de Toxicologie Clinique et Experimentale</em> (1st summerschool), <em>Toxicology </em>(2nd to 10th summerschools) and will be published in <em>Perspectives in Experimental and Clinical Immunotoxicology&#160;</em>(immunotoxicology-online), starting from the 13th summerschool.</p>"
  index_page.parts.save!
end

if defined?(::Refinery::Page)
  show_page = ::Refinery::Page.create(
    :title => 'Next School',
    :link_url => "",
    :deletable => false,
    :menu_match => nil,
    :skip_to_first_child => true
  )
  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
    show_page.parts.create(:title => default_page_part, :body => nil, :position => index)
  end
end

program_url = "/program"
if defined?(::Refinery::Page) && ::Refinery::Page.where(:link_url => program_url).empty?
  program_page = ::Refinery::Page.create(
    :parent_id => show_page.id,
    :title => 'Program',
    :link_url => program_url,
    :deletable => false,
    :menu_match => "^#{program_url}(\/|\/.+?|)$"
  )
  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
    program_page.parts.create(:title => default_page_part, :body => nil, :position => index)
  end
end

registration_url = "/registration"
if defined?(::Refinery::Page) && ::Refinery::Page.where(:link_url => registration_url).empty?
  registration_page = ::Refinery::Page.create(
    :parent_id => show_page.id,
    :title => 'Registration Form',
    :link_url => registration_url,
    :deletable => false,
    :menu_match => "^#{registration_url}(\/|\/.+?|)$"
  )
  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
    registration_page.parts.create(:title => default_page_part, :body => nil, :position => index)
  end
end

thank_you_url = "/thank_you"
if defined?(::Refinery::Page) && ::Refinery::Page.where(:link_url => thank_you_url).empty?
  thank_you_page = ::Refinery::Page.create(
    :title => 'Thank You',
    :show_in_menu => false,
    :link_url => thank_you_url,
    :deletable => false,
    :menu_match => nil,
    :skip_to_first_child => true
  )
  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
    thank_you_page.parts.create(:title => default_page_part, :body => nil, :position => index)
  end
end

%w(canceled accepted refused).each do |name|
  payment_url = "/payment_#{name}"
  if defined?(::Refinery::Page) && ::Refinery::Page.where(:link_url => payment_url).empty?
    page = ::Refinery::Page.create(
      :title => "Payment #{name.titleize}",
      :show_in_menu => false,
      :link_url => payment_url,
      :deletable => false,
      :menu_match => nil,
      :skip_to_first_child => true
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end
end
