module ProjectsHelper
  include ActionView::Helpers::TagHelper

  SHOW_PAGE_AROUND = 2

  def paginate_projects(provider, owner, per_page, page, project_count)
    return '' if project_count == 0

    per_page ||= 20
    page ||= '1'
    paginate_projects_html(provider, owner, per_page, page.to_i, project_count)
  end

  private
  def paginate_projects_html(provider, owner, per_page, page, project_count)
    page_count = (project_count / per_page) + (project_count % per_page == 0 ? 0 : 1)
    content_tag(:div, class: 'pagination') do
      ul = content_tag(:ul, false) do
        lis = ''
        unless page == 1
          lis << content_tag(:li) do
            link_to('&laquo; First'.html_safe, projects_from_service_path(provider: provider, owner: owner, page: 1)).html_safe
          end
          lis << content_tag(:li) do
            link_to('&lsaquo; Prev'.html_safe, projects_from_service_path(provider: provider, owner: owner, page: page - 1)).html_safe
          end
        end

        if page - SHOW_PAGE_AROUND >= 2
          lis << content_tag(:li, class: 'disabled') do
            link_to('...', '#')
          end
        end

        (page - SHOW_PAGE_AROUND).upto(page + SHOW_PAGE_AROUND) do |i|
          if i >= 1 and i <= page_count
            lis << content_tag(:li) do
              link_to(i, projects_from_service_path(provider: provider, owner: owner, page: i)).html_safe
            end
          end
        end

        if  page + SHOW_PAGE_AROUND < page_count
          lis << content_tag(:li, class: 'disabled') do
            link_to('...', '#')
          end
        end

        unless page == page_count
          lis << content_tag(:li) do
            link_to('Next &rsaquo;'.html_safe, projects_from_service_path(provider: provider, owner: owner, page: page + 1)).html_safe
          end
          lis << content_tag(:li) do
            link_to('Last &raquo;'.html_safe, projects_from_service_path(provider: provider, owner: owner, page: page_count)).html_safe
          end
        end
        lis.html_safe
      end.html_safe
    end
  end
end
