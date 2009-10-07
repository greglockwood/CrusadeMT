module Shared
  module FullAddress
      def full_address(separator = "\n")
        fa = ""
        fa += "#{address1}#{separator}" unless !address1?
        fa += "#{address2}#{separator}" unless !address2?
        fa += "#{address3}#{separator}" unless !address3?
        fa += "#{suburb} #{state.abbreviation} #{postcode}"
        fa
      end
  end
end