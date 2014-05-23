module PostSearch
  class << self
    def with_params(params, published = nil, paging = {})
      Post.search :load => true, **paging do

        categories = params[:categories]
        job_phase  = params[:job_phase]
        post_type  = params[:post_type]

        query do
          string params[:q] || '*'
        end

        if categories; filter :terms, :categories => categories.split(',') end
        if job_phase; filter :terms,  :job_phase => job_phase.downcase().split(',') end
        if post_type; filter :terms,  :type => post_type.downcase().split(',') end
        if published; filter :range, :published_at => { :lte => DateTime.now } end

        sort do
          by :published_at, :desc
          by :created_at, :desc
        end
      end
    end
  end
end
