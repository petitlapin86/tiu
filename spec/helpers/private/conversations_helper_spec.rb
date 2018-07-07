require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Private::ConversationsHelper. For example:
#
# describe Private::ConversationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Private::ConversationsHelper, type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"

  context '#load_private_messages' do
  let(:conversation) { create(:private_conversation) }

  it "returns load_messages partial's path" do
    create(:private_message, conversation_id: conversation.id)
    expect(helper.load_private_messages(conversation)).to eq (
      'private/conversations/conversation/messages_list/link_to_previous_messages'
    )
  end

  it "returns empty partial's path" do
    expect(helper.load_private_messages(conversation)).to eq (
      'shared/empty_partial'
    )
  end
end

context '#add_to_contacts_partial_path' do
  let(:contact) { create(:contact) }

  it "returns an empty partial's path" do
    helper.stub(:recipient_is_contact?).and_return(true)
    expect(helper.add_to_contacts_partial_path(contact)).to eq(
      'shared/empty_partial'
    )
  end

  it "returns add_user_to_contacts partial's path" do
    helper.stub(:recipient_is_contact?).and_return(false)
    helper.stub(:unaccepted_contact_exists).and_return(false)
    expect(helper.add_to_contacts_partial_path(contact)).to eq(
      'private/conversations/conversation/heading/add_user_to_contacts'
    )
  end
end

context 'private scope' do
  let(:current_user) { create(:user) }
  let(:recipient) { create(:user) }

  context '#unaccepted_contact_exists' do
    it 'returns false' do
      contact = create(:contact, accepted: true)
      expect(helper.instance_eval {
        unaccepted_contact_exists(contact)
      }).to eq false
    end

    it 'returns false' do
      contact = nil
      expect(helper.instance_eval {
        unaccepted_contact_exists(contact)
      }).to eq false
    end

    it 'returns true' do
      contact = create(:contact, accepted: false)
      expect(helper.instance_eval {
        unaccepted_contact_exists(contact)
      }).to eq true
    end
  end

  context '#recipient_is_contact?' do
    it 'returns false' do
      helper.stub(:current_user).and_return(current_user)
      assign(:recipient, recipient)
      create_list(:contact, 2, user_id: current_user.id, accepted: true)
      expect(helper.instance_eval { recipient_is_contact? }).to eq false
    end

    it 'returns true' do
      helper.stub(:current_user).and_return(current_user)
      assign(:recipient, recipient)
      create_list(:contact, 2, user_id: current_user.id, accepted: true)
      create(:contact,
              user_id: current_user.id,
              contact_id: recipient.id,
              accepted: true)
      expect(helper.instance_eval { recipient_is_contact? }).to eq true
    end
  end
end

end
