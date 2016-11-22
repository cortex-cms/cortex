require 'spec_helper'

describe Abilities::UserAbility, :type => :model do

  begin
    context 'Class' do
      context 'Subject is a User' do
        let (:subject) { User }

        context 'User is an Admin' do
          it 'should be able to view and create' do
            admin = build(:user, :admin)
            abilities = Abilities::UserAbility.allowed(admin, subject)
            expect(abilities).to eq([:view, :create])
          end
        end

        context 'User is not an Admin' do
          it 'should have no abilities' do
            user = build(:user)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([])
          end
        end
      end

      context 'Subject is a Tenant' do
        let (:subject) { Tenant }

        context 'User is an Admin' do
          it 'should be able to view and create' do
            admin = build(:user, :admin)
            abilities = Abilities::UserAbility.allowed(admin, subject)
            expect(abilities).to eq([:view, :create])
          end
        end

        context 'User is not an Admin' do
          it 'should have no abilities' do
            user = build(:user)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([])
          end
        end
      end

      context 'Subject is a Post' do
        let (:subject) { Post }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is a Media' do
        let (:subject) { Media }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is a Category' do
        let (:subject) { Category }

        it 'should be able to view' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view])
        end
      end

      context 'Subject is a Localization' do
        let (:subject) { Localization }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is a Locale' do
        let (:subject) { Locale }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is an Application' do
        let (:subject) { Application }

        context 'User is an Admin' do
          it 'should be able to view and create' do
            admin = build(:user, :admin)
            abilities = Abilities::UserAbility.allowed(admin, subject)
            expect(abilities).to eq([:view, :create])
          end
        end

        context 'User is not an Admin' do
          it 'should have no abilities' do
            user = build(:user)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([])
          end
        end
      end

      context 'Subject is a BulkJob' do
        let (:subject) { BulkJob }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is a Document' do
        let (:subject) { Document }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is a Webpage' do
        let (:subject) { Webpage }

        context 'User is an Admin' do
          it 'should be able to view and create' do
            admin = build(:user, :admin)
            abilities = Abilities::UserAbility.allowed(admin, subject)
            expect(abilities).to eq([:view, :create])
          end
        end

        context 'User is not an Admin' do
          it 'should be able to view' do
            user = build(:user)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([:view])
          end
        end
      end

      context 'Subject is a Snippet' do
        let (:subject) { Snippet }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is a ContentItem' do
        let (:subject) { ContentItem }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end

      context 'Subject is a ContentType' do
        let (:subject) { ContentType }

        it 'should be able to view' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view])
        end
      end
    end

    context 'Instance' do
      context 'Subject is a User' do
        let (:subject) { create(:user) }

        context 'User is modifying itself' do
          it 'should be able to view, update, and delete' do
            user = subject
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([:view, :update, :delete])
          end
        end

        context 'User is an Admin' do
          it 'should be able to view, update, and delete' do
            admin = build(:user, :admin)
            abilities = Abilities::UserAbility.allowed(admin, subject)
            expect(abilities).to eq([:view, :update, :delete])
          end
        end

        context 'User is not an Admin and not modifying itself' do
          it 'should have no abilities' do
            user = build(:user, id: subject.id + 1)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([])
          end
        end
      end

      context 'Subject is a Tenant' do
        let (:subject) { build(:tenant) }

        context 'User is an Admin' do
          it 'should be able to view, update, and delete' do
            admin = build(:user, :admin)
            abilities = Abilities::UserAbility.allowed(admin, subject)
            expect(abilities).to eq([:view, :update, :delete])
          end
        end

        context 'User is not an Admin' do
          it 'should have no abilities' do
            user = build(:user)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([])
          end
        end
      end

      context 'Subject is a Post' do
        let (:subject) { build(:post) }

        it 'should be able to view, update, and delete' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :update, :delete])
        end
      end

      context 'Subject is a Media' do
        let (:subject) { build(:media) }

        it 'should be able to view, update, and delete' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :update, :delete])
        end
      end

      context 'Subject is a Localization' do
        let (:subject) { build(:localization) }

        it 'should be able to view, update, and delete' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :update, :delete])
        end
      end

      context 'Subject is a Locale' do
        let (:subject) { build(:locale) }

        it 'should be able to view, update, and delete' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :update, :delete])
        end
      end

      context 'Subject is an Application' do
        let (:subject) { build(:application) }

        context 'Shared Tenant' do
          it 'should be able to view, update, and delete' do
            user = build(:user, tenant_id: subject.tenant_id)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([:view, :update, :delete])
          end
        end

        context 'Not Shared Tenant' do
          let (:tenant) { build(:tenant, :second_tenant) }

          context 'User is an Admin' do
            it 'should be able to view, update, and delete' do
              admin = build(:user, :admin, tenant: tenant)
              abilities = Abilities::UserAbility.allowed(admin, subject)
              expect(abilities).to eq([:view, :update, :delete])
            end
          end

          context 'User is not an Admin' do
            it 'should have no abilities' do
              user = build(:user, tenant: tenant)
              abilities = Abilities::UserAbility.allowed(user, subject)
              expect(abilities).to eq([])
            end
          end
        end
      end

      context 'Subject is a BulkJob' do
        let (:subject) { build(:bulk_job) }

        it 'should be able to view, update, and delete' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :update, :delete])
        end
      end

      context 'Subject is a Document' do
        let (:subject) { build(:document) }

        it 'should be able to view, update, and delete' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :update, :delete])
        end
      end

      context 'Subject is a Webpage' do
        let (:subject) { build(:webpage) }

        context 'User is an Admin' do
          it 'should be able to view, update, and delete' do
            admin = build(:user, :admin)
            abilities = Abilities::UserAbility.allowed(admin, subject)
            expect(abilities).to eq([:view, :update, :delete])
          end
        end

        context 'User is not an Admin' do
          it 'should be able to view' do
            user = build(:user)
            abilities = Abilities::UserAbility.allowed(user, subject)
            expect(abilities).to eq([:view])
          end
        end
      end

      # Mysteriously broken.. it's trying to persist the snippet, which is breaking ES
      xcontext 'Subject is a Snippet' do
        let (:user) { build(:user) }
        let (:subject) { build(:snippet, user: user) }

        it 'should be able to view, update, and delete' do
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :update, :delete])
        end
      end

      context 'Subject is a ContentType' do
        let (:subject) { build(:content_type) }

        it 'should be able to view' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view])
        end
      end

      context 'Subject is a ContentItem' do
        let (:subject) { build(:content_item) }

        it 'should be able to view and create' do
          user = build(:user)
          abilities = Abilities::UserAbility.allowed(user, subject)
          expect(abilities).to eq([:view, :create])
        end
      end
    end
  end

end
