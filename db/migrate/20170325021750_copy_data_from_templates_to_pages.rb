class CopyDataFromTemplatesToPages < ActiveRecord::Migration[5.0]
  class Page < ApplicationRecord
  end

  class Template < ApplicationRecord
  end

  def up
    template = Template.first
    Page.create_with(text: template.about_text, slider: template.about_slider, slug: 'about').find_or_create_by!(name: 'About')
    Page.create_with(text: template.contact_details, slug: 'contact').find_or_create_by!(name: 'Contact')
    Page.create_with(text: template.feedback_text, slider: template.feedback_slider, slug: 'feedbacks').find_or_create_by!(name: 'Feedbacks')
    Page.create_with(slug: 'log-in').find_or_create_by!(name: 'Log in')
    Page.create_with(text: template.how_it_works_text, slug: 'how-it-works').find_or_create_by!(name: 'How it works')
    Page.create_with(text: template.privacy, slug: 'privacy').find_or_create_by!(name: 'Privacy policy')
    Page.create_with(slug: 'sitemap').find_or_create_by!(name: 'Sitemap')
    Page.create_with(text: template.start_selling, slug: 'start-selling').find_or_create_by!(name: 'Start selling')
    Page.create_with(text: template.terms, slug: 'terms').find_or_create_by!(name: 'Terms & Conditions')
    Page.create_with(text: template.trust_and_safety_text, slug: 'trust-and-safety').find_or_create_by!(name: 'Trust & Safety')
  end

  def down
    template = Template.first

    page = Page.find_by!(name: 'About')
    template.update!(about_text: page.text, about_slider: page.slider)
    page = Page.find_by!(name: 'Contact')
    template.update!(contact_details: page.text)
    page = Page.find_by!(name: 'Feedbacks')
    template.update!(feedback_text: page.text, feedback_slider: page.slider)
    page = Page.find_by!(name: 'How it works')
    template.update!(how_it_works_text: page.text)
    page = Page.find_by!(name: 'Privacy policy')
    template.update!(privacy: page.text)
    page = Page.find_by!(name: 'Start selling')
    template.update!(start_selling: page.text)
    page = Page.find_by!(name: 'Terms & Conditions')
    template.update!(terms: page.text)
    page = Page.find_by!(name: 'Trust & Safety')
    template.update!(trust_and_safety_text: page.text)
  end
end
