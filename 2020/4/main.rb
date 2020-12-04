passports = File.read("input.txt").split(/^\s?$/).map { |x| x.chomp.lstrip.gsub("\n", " ") }

valid_field = 0

required_fields = [
  "byr",
  "iyr",
  "eyr",
  "hgt",
  "hcl",
  "ecl",
  "pid",
]

validations = {
  "byr" => -> (val) { val.to_i >= 1920 && val.to_i <= 2002 && !!(val =~ /^[0-9]{4}$/) },
  "iyr" => -> (val) { val.to_i >= 2010 && val.to_i <= 2020 && !!(val =~ /^[0-9]{4}$/) },
  "eyr" => -> (val) { val.to_i >= 2020 && val.to_i <= 2030 && !!(val =~ /^[0-9]{4}$/) },
  "hgt" => -> (val) { !!(val =~ /\d+(cm|in)/) && ($1 == "cm" ? (val.to_i >= 150 && val.to_i <= 193) : ((val.to_i >= 59 && val.to_i <= 76))) },
  "hcl" => -> (val) { !!(val =~ /#[0-9a-f]{6}/) },
  "ecl" => -> (val) { !!(val =~ /amb|blu|brn|gry|grn|hzl|oth/) },
  "pid" => -> (val) { !!(val =~ /^\d{9}$/) } ,
  "cid" => -> (_) { true }
}

passports.each do |p|
  fields = p.split(" ")

  req_fields = fields.select do |field|
    f = field.split(":")
    valid = validations[f[0]].call(f[1])
    required_fields.include?(f[0]) && validations[f[0]].call(f[1])
  end
  valid_field += 1 if req_fields.count == required_fields.count

end

puts valid_field
