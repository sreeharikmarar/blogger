# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it {
      should validate_length_of(:description)
        .is_at_most(500)
    }

    it { should belong_to(:post) }
    it { should belong_to(:user) }

    it 'does not create comment when description is empty' do
      comment = described_class.new(description: '',
                                    post_id: post.id,
                                    user_id: user.id)

      expect(comment.valid?).to be_falsey
    end

    it 'does not create comment when user is not set' do
      comment = described_class.new(description: 'some dummy comments',
                                    user_id: nil,
                                    post_id: post.id)

      expect(comment.valid?).to be_falsey
    end

    it 'does not create comment when post is not set' do
      comment = described_class.new(description: '',
                                    user_id: user.id,
                                    post_id: nil)

      expect(comment.valid?).to be_falsey
    end
  end

  describe 'creation' do
    it 'creates a comment when the request is valid' do
      comment = described_class.create(description: 'some dummy comments',
                                       user_id: user.id,
                                       post_id: post.id)

      expect(comment).to be_persisted
      expect(comment.description).to eq('some dummy comments')
      expect(comment.user).to eq(user)
      expect(comment.post).to eq(post)
    end
  end
end
