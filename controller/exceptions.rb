class ExceptionHTTP < Exception
end	

class Exception4XX < ExceptionHTTP
end

class Exception404 < Exception4XX
end

class Exception401 < Exception4XX
end

class Exception400 < Exception4XX
	def initialize(msg="My default message", thing="apple")
    @thing = thing
    super(msg)
  end
end

