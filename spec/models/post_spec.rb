# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it {
      should validate_length_of(:title)
        .is_at_least(5)
    }

    it { should validate_presence_of(:content) }
    it { should belong_to(:user) }

    it 'does not create post when title is empty' do
      post = described_class.new(title: '',
                                 content: 'Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et.',
                                 user_id: user.id)

      expect(post.valid?).to be_falsey
    end

    it 'does not create post when title is less than 5 characters' do
      post = described_class.new(title: 'Rec',
                                 content: 'Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et.',
                                 user_id: user.id)

      expect(post.valid?).to be_falsey
    end

    it 'does not create post when content is empty' do
      post = described_class.new(title: 'Recusandae minima consequatur',
                                 content: '',
                                 user_id: user.id)

      expect(post.valid?).to be_falsey
    end

    it 'does not create post when content is less than 10 character' do
      post = described_class.new(title: 'Recusandae minima consequatur',
                                 content: 'Recusa',
                                 user_id: user.id)

      expect(post.valid?).to be_falsey
    end

    it 'doest not create post when user is not set' do
      post = described_class.new(title: 'Recusandae minima consequatur',
                                 content: 'Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et.',
                                 user_id: nil)

      expect(post.valid?).to be_falsey
    end
  end

  describe 'creation' do
    it 'creates a post when the req uest is valid' do
      post = described_class.create(title: 'Recusandae minima consequatur',
                                    content: 'Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et.',
                                    user_id: user.id)

      expect(post).to be_persisted
      expect(post.title).to eq('Recusandae minima consequatur')
      expect(post.content).to eq('Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et.')
      expect(post.user).to eq(user)
    end
  end
end
