module Shared
  module FullAddress
      def full_address
        fa = ""
        fa += "#{address1}\n" unless !address1?
        fa += "#{address2}\n" unless !address2?
        fa += "#{address3}\n" unless !address3?
        fa += "#{suburb} #{state.abbreviation} #{postcode}"
        fa
      end
  end
end