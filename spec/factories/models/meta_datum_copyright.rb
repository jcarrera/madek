FactoryGirl.define do

  factory :meta_datum_copyright do
    meta_key { MetaKey.find_by_label "copyright status" } 
  end

end


