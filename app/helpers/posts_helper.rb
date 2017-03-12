module PostsHelper
  def self.similar_posts post
    results = Post.collection.aggregate(
      {
        "$match" => {  tags: { "$in" => post.tags.to_a }, _id: { "$ne" => post.id }, _blog_type: { "$ne" => "mini_site"} },
      },
      { "$unwind" => "$tags" },
      { "$match" => { tags: { "$in" => post.tags.to_a } } },
      { "$group" => { _id: "$_id", matches: { "$sum" =>1 } } },
      { "$sort" => { matches: -1 } },
      { "$limit" => 4 }
    )

    objects = []
    results.map(&:first).map(&:last).each do |result|
      objects << (Post.find result)
    end
    objects
  end

  def self.string_posted_time post
      str = ""
      diff = Time.diff(post.created_at, Time.zone.now)

      p diff
      if  diff[:year] > 0
        str = Time.diff(post.created_at, Time.zone.now, "%y")[:diff]
      elsif  diff[:month] > 0
        str = Time.diff(post.created_at, Time.zone.now, "%M")[:diff]
      elsif  diff[:week] > 0
        str = Time.diff(post.created_at, Time.zone.now, "%w")[:diff]
      elsif  diff[:day] > 0
        str = Time.diff(post.created_at, Time.zone.now, "%d")[:diff]
      elsif  diff[:hour] > 0
        str = Time.diff(post.created_at, Time.zone.now, "%H")[:diff]
      elsif  diff[:minute] > 0
        str = Time.diff(post.created_at, Time.zone.now, "%N")[:diff]
      elsif  diff[:second] > 0
        str = Time.diff(post.created_at, Time.zone.now, "%S")[:diff]
      end
      str
  end

  def self.can_shoot_tags?
    tags = []

    Post.all.each do |tt|
      if tt.tags
        tt.tags.each do |t|
          tags.push(t)
        end
      end
    end

    tags.sort_by{rand}[0..9] if tags.count > 0
  end
end
