module MembersHelper
  def birthday_style(member)
    return 'gone-birthday' if (member.birth_month == Time.now.month and member.birth_day < Time.now.day)
    ''
  end
end
