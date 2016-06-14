module Error
  class EmptyPost < ArgumentError; end
  class NoTitle < ArgumentError; end
  class TitleEmpty < ArgumentError; end
  class NoBody < ArgumentError; end
  class BodyEmpty < ArgumentError; end
  class NoPassword < ArgumentError; end
  class PasswordEmpty < ArgumentError; end

  class AccessDenied < RangeError; end
end
