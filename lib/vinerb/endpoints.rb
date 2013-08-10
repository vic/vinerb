  module Vinerb::Endpoints

    API_URL = "https://api.vineapp.com/"
    MEDIA_URL = "http://media.vineapp.com/"
    HEADERS = {"User-Agent"=>"com.vine.iphone/1.0.3 (unknown, iPhone OS 6.0.1, iPhone, Scale/2.000000)", "Accept-Language"=>"en, sv, fr, de, ja, nl, it, es, pt, pt-PT, da, fi, nb, ko, zh-Hans, zh-Hant, ru, pl, tr, uk, ar, hr, cs, el, he, ro, sk, th, id, ms, en-GB, ca, hu, vi, en-us;q=0.8"}

    

      def login(username, password,  optionals = {} )
        deviceToken = optionals["deviceToken"] || optionals[:deviceToken]
        deviceToken = "0cc1dab0dab0dab0dab0dab0dab0dab0dab0dab0dab0dab0dab0dab0dab0dab0" if deviceToken.nil?
        url = (API_URL + "users/authenticate") % []
        params = {  "deviceToken" => deviceToken ,  "username" => username ,  "password" => password  }.reject { |k, v| v.nil? }
        api_call "post", url, params, "User"
      end


      def logout( optionals = {} )
        
        
        url = (API_URL + "users/authenticate") % []
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def signup(email, password, username,  optionals = {} )
        authenticate = optionals["authenticate"] || optionals[:authenticate]
        authenticate = 1 if authenticate.nil?
        url = (API_URL + "users") % []
        params = {  "authenticate" => authenticate ,  "email" => email ,  "password" => password ,  "username" => username  }.reject { |k, v| v.nil? }
        api_call "post", url, params, "User"
      end


      def get_me( optionals = {} )
        
        
        url = (API_URL + "users/me") % []
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "User"
      end


      def get_user(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/profiles/%s") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "User"
      end


      def update_profile(user_id,  optionals = {} )
        description = optionals["description"] || optionals[:description]; location = optionals["location"] || optionals[:location]; locale = optionals["locale"] || optionals[:locale]; private = optionals["private"] || optionals[:private]; phoneNumber = optionals["phoneNumber"] || optionals[:phoneNumber]
        
        url = (API_URL + "users/%s") % [user_id]
        params = {  "description" => description ,  "location" => location ,  "locale" => locale ,  "private" => private ,  "phoneNumber" => phoneNumber  }.reject { |k, v| v.nil? }
        api_call "post", url, params, "User"
      end


      def set_explicit(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/explicit") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "post", url, params, nil
      end


      def unset_explicit(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/explicit") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def follow(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/followers") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "post", url, params, nil
      end


      def unfollow(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/followers") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def block(from_user_id, to_user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/blocked/%s") % [from_user_id, to_user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "post", url, params, nil
      end


      def unblock(from_user_id, to_user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/blocked/%s") % [from_user_id, to_user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def get_pending_notifications_count(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/pendingNotificationsCount") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, nil
      end


      def get_notifications(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/notifications") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, nil
      end


      def get_followers(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/followers") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "UserCollection"
      end


      def get_following(user_id,  optionals = {} )
        
        
        url = (API_URL + "users/%s/following") % [user_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "UserCollection"
      end


      def like(post_id,  optionals = {} )
        
        
        url = (API_URL + "posts/%s/likes") % [post_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "post", url, params, "Like"
      end


      def unlike(post_id,  optionals = {} )
        
        
        url = (API_URL + "posts/%s/likes") % [post_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def comment(post_id, comment, entities,  optionals = {} )
        
        
        url = (API_URL + "posts/%s/comments") % [post_id]
        params = {  "comment" => comment ,  "entities" => entities  }.reject { |k, v| v.nil? }
        api_call "post", url, params, "Comment"
      end


      def uncomment(post_id, comment_id,  optionals = {} )
        
        
        url = (API_URL + "posts/%s/comments/%s") % [post_id, comment_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def revine(post_id,  optionals = {} )
        
        
        url = (API_URL + "posts/%s/repost") % [post_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "post", url, params, "Repost"
      end


      def unrevine(post_id, revine_id,  optionals = {} )
        
        
        url = (API_URL + "posts/%s/repost/%s") % [post_id, revine_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def report( optionals = {} )
        
        
        url = (API_URL + "posts/%s/complaints") % []
        params = {  }.reject { |k, v| v.nil? }
        api_call "post", url, params, nil
      end


      def post(videoUrl, thumbnailUrl, description, entities,  optionals = {} )
        forsquareVenueId = optionals["forsquareVenueId"] || optionals[:forsquareVenueId]; venueName = optionals["venueName"] || optionals[:venueName]; channelId = optionals["channelId"] || optionals[:channelId]
        
        url = (API_URL + "posts") % []
        params = {  "forsquareVenueId" => forsquareVenueId ,  "venueName" => venueName ,  "channelId" => channelId ,  "videoUrl" => videoUrl ,  "thumbnailUrl" => thumbnailUrl ,  "description" => description ,  "entities" => entities  }.reject { |k, v| v.nil? }
        api_call "post", url, params, nil
      end


      def delete_post(post_id,  optionals = {} )
        
        
        url = (API_URL + "posts/%s") % [post_id]
        params = {  }.reject { |k, v| v.nil? }
        api_call "delete", url, params, nil
      end


      def get_post(post_id,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/posts/%s") % [post_id]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_user_timeline(user_id,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/users/%s") % [user_id]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_user_likes(user_id,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/users/%s/likes") % [user_id]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_tag_timeline(tag_name,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/tags/%s") % [tag_name]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_main_timeline( optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/graph") % []
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_popular_timeline( optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/popular") % []
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_ontherise_timeline( optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/trending") % []
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_editorpicks_timeline( optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/promoted") % []
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_channel_popular_timeline(channel_id,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/channels/%s/popular") % [channel_id]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_channel_recent_timeline(channel_id,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/channels/%s/recent") % [channel_id]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_venue_timeline(venue_id,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "timelines/venues/%s") % [venue_id]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "PostCollection"
      end


      def get_trending_tags( optionals = {} )
        
        
        url = (API_URL + "tags/trending") % []
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "TagCollection"
      end


      def get_featured_channels( optionals = {} )
        
        
        url = (API_URL + "channels/featured") % []
        params = {  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "ChannelCollection"
      end


      def search_tags(tag_name,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "tags/search/%s") % [tag_name]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "TagCollection"
      end


      def search_users(query,  optionals = {} )
        size = optionals["size"] || optionals[:size]; page = optionals["page"] || optionals[:page]; anchor = optionals["anchor"] || optionals[:anchor]
        
        url = (API_URL + "users/search/%s") % [query]
        params = {  "size" => size ,  "page" => page ,  "anchor" => anchor  }.reject { |k, v| v.nil? }
        api_call "get", url, params, "UserCollection"
      end


  end
