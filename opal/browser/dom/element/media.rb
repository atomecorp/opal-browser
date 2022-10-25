module Browser

  module DOM

    class Element < Node

      class Media < Element
        def play
          `#@native.play()`
        end

        def pause
          `#@native.pause()`
        end

        def currentTime= (val)
          `#@native.currentTime = #{val};`
        end

        def currentTime
          `#@native.currentTime`
        end
      end

      class Video < Media
        def_selector "video"
      end

      class Audio < Media
        def_selector "audio"
      end

    end
  end
end
