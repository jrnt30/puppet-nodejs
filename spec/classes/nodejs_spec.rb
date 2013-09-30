require "spec_helper"

describe "nodejs" do
  let(:facts) { default_test_facts }

  let(:root) { "/test/boxen/nodenv" }
  let(:versions) { "#{root}/versions" }
  

  it do
    should include_class("nodejs::rehash")
    should include_class("nodejs::nvm")

    should contain_repository(root).with({
      :ensure => "v0.3.3",
      :force  => true,
      :source => "wfarr/nodenv",
      :user   => "testuser"
    })

    should contain_file(versions).with_ensure("directory")
  end
  
  context "Darwin" do
    it do 
      should contain_file("/test/boxen/env.d/nodenv.sh")
    end
  end

  context "Linux" do
    let(:facts) { default_test_facts.merge(:osfamily => "Linux") }

    it {
      should contain_file("/etc/profile.d/nodenv.sh")
    }
  end
end
