require 'spec_helper'

describe Browser::DOM::MutationObserver do
  html <<-HTML
    <div id="mutate">
      <span></span>
    </div>
  HTML

  it 'notifies additions' do
    promise = Browser::Promise.new
    obs = Browser::DOM::MutationObserver.new {|mutations|
      expect(mutations.first.added.first.name).to eq('DIV')
      promise.resolve

      obs.disconnect
    }

    obs.observe $document[:mutate]

    $document[:mutate].add_child $document.create_element('div')

    promise.for_rspec
  end

  it 'notifies removals' do
    promise = Browser::Promise.new
    obs = Browser::DOM::MutationObserver.new {|mutations|
      expect(mutations.first.removed.first.name).to eq('SPAN')
      promise.resolve

      obs.disconnect
    }

    obs.observe $document[:mutate]

    $document[:mutate].first_element_child.remove

    promise.for_rspec
  end
end if Browser::DOM::MutationObserver.supported?
