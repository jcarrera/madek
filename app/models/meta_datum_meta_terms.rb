# -*- encoding : utf-8 -*-
 
class MetaDatumMetaTerms < MetaDatum
  has_and_belongs_to_many :meta_terms, 
    join_table: :meta_data_meta_terms, 
    foreign_key: :meta_datum_id, 
    association_foreign_key: :meta_term_id

  def to_s
    value.map(&:to_s).join("; ")
  end

  def value
    meta_terms
  end

  def value=(new_value)
    new_meta_terms = Array(new_value).map do |v|
      if v.is_a?(MetaTerm)
        v
      elsif v.is_a?(Fixnum) or (v.respond_to?(:is_integer?) and v.is_integer?)
        # TODO check if is member of meta_key.meta_terms
        MetaTerm.find_by_id(v)
      elsif meta_key.is_extensible_list?
        h = {}
        LANGUAGES.each {|lang| h[lang] = v}
        term = MetaTerm.find_or_initialize_by_en_gb_and_de_ch(h)
        meta_key.meta_terms << term unless meta_key.meta_terms.include?(term)
        term
      elsif v.is_a?(String) # the meta_key is not extensible list
        h = {}
        LANGUAGES.each {|lang| h[lang] = v}
        meta_key.meta_terms.where(h).first
      else
        v
      end
    end
    meta_terms.clear
    meta_terms << new_meta_terms.compact
  end

end


