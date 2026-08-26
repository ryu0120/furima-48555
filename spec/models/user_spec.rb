require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要な情報が全て正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank",
                                                      'First name is invalid. Input full-width characters')
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank",
                                                      'Last name is invalid. Input full-width characters')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank",
                                                      'First name kana is invalid. Input full-width katakana characters')
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank",
                                                      'Last name kana is invalid. Input full-width katakana characters')
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '1234ab'
        @user.password_confirmation = '1234abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordは半角英字が含まれてないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordは半角数字が含まれてないと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordは半角英数字以外の文字が含まれていると登録できない' do
        @user.password = '123ab@'
        @user.password_confirmation = '123ab@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）以外の文字が含まれていると登録できない' do
        @user.first_name = '山da'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）以外の文字が含まれていると登録できない' do
        @user.last_name = 'たろu'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
      end

      it 'first_name_kanaは全角（カタカナ）以外の文字が含まれていると登録できない' do
        @user.first_name_kana = 'ヤマ田'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end

      it 'last_name_kanaは全角（カタカナ）以外の文字が含まれていると登録できない' do
        @user.last_name_kana = 'タrou'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
      end
    end
  end
end
