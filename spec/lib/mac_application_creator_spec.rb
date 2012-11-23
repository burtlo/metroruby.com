require 'spec_helper'

describe Metro::MacApplicationCreator do

  subject { described_class.new source, target }

  let(:root_path) { File.absolute_path File.join Rails.root, 'public', 'archives', 'user', 'game' }

  let(:source) { File.join root_path, 'source'  }
  let(:target) { File.join root_path,  'finalgame.app' }

  let(:expected_application_wrapper_path) { File.absolute_path File.join Rails.root, 'public', 'Game.app' }
  its(:application_wrapper_path) { should eq expected_application_wrapper_path }

  let(:expected_source_target_path) { File.join target, 'Contents', 'Resources', 'application' }

  its(:source_target_path) { should eq expected_source_target_path }

  describe "#create!" do
    it "should copy the original wrapper to the final wrapper path and copy the source into it." do
      FileUtils.should_receive(:cp_r).with(expected_application_wrapper_path,target)
      FileUtils.should_receive(:cp_r).with([],expected_source_target_path)
      subject.create!
    end
  end

  let(:expected_amazon_archive) { "user/game/mac.tar.gz" }
  its(:amazon_archive) { should eq expected_amazon_archive }

end
