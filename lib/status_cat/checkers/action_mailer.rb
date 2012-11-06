module StatusCat
  module Checkers
    class ActionMailer < Base

      def initialize
        @value = "#{config[ :address ]}:#{config[ :port ]}"

        unless  ::ActionMailer::Base.delivery_method == :test
          @status = fail_on_exception do
              address        = config[ :address ]
              port           = config[ :port ]
              domain         = config[ :domain ]
              user_name      = config[ :user_name ]
              password       = config[ :password ]
              authentication = config[ :authentication ]

              # TODO nil user_name and password were a pass.  Tighten down checks here

              Net::SMTP.start( address, port, domain, user_name, password, authentication ) { |smtp| }
            end
          end
      end

      def config
        @config ||= ::ActionMailer::Base.smtp_settings
      end

    end
  end
end