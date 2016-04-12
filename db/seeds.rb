def generate_secret
  SecureRandom.base64(6)
end

ApiKey.create(token: 'secret_token')

panel_providers_codes = ['FirstPanel', 'SecondPanel', 'ThirdPanel']

panel_providers_codes.each do |code|
  PanelProvider.create(code: code)
end

country_codes = ['pl', 'gb', 'de']

PanelProvider.all.each_with_index do |panel_provider, index|
  Country.create(country_code: country_codes[index], panel_provider_id: panel_provider.id)
end

locations = {
  pl: {
    'województwo małopolskie' => {
      'gmina Kraków' => ['Kraków'],
      'gmina Krzeszowice' => ['Krzeszowice', 'Czerna']
    },
    'województwo wielkopolskie' => {
      'gmina Warszawa' => ['Warszawa'],
      'gmina Radom' => ['Radom']
    },
  },
  gb: {
    'Greater London' => {
      'London' => ['Addington', 'Abbey Wood'],
    },
  },
  de: {
    'Brandenburg' => {
      'Berlin' => ['Lichtenberg', 'Pankow', 'Spandau']
    }
  }
}

locations_names = locations.map do |country, root| 
  {
    country => root.map do |root, district| 
      [root, district.map { |district, leafs| [district, leafs] } ].flatten
    end
  }
end.reduce({}, :merge)

locations_names.each do |country_code, names|
  names.flatten.each do |name|
    Location.create(name: name, secret_code: generate_secret)
  end
end

four_providers = PanelProvider.all + [PanelProvider.first]

locations.each do |country_code, country|
  country.each do |group_name, districts|
    panel_provider_index = 0
    districts.each do |district|
      panel_provider = four_providers[panel_provider_index]
      locations_in_group = district.flatten.map { |location| Location.find_by_name(location) }
      group = LocationGroup.create(
        name: "Group #{group_name}", 
        locations: locations_in_group, 
        panel_provider: panel_provider,
        country: Country.find_by_country_code(country_code)
      )
      panel_provider_index += 1
    end
  end
end

locations.each do |country_code, country|
  country.each do |root_name, districts|
    panel_provider_index = 0
    panel_provider = four_providers[panel_provider_index]
    root = TargetGroup.create(
      name: root_name, 
      secret_code: generate_secret,
      panel_provider: panel_provider,
      countries: [Country.find_by_country_code(country_code)]
    )
    districts.each do |district_name, leafs|
      district = TargetGroup.create(
        name: district_name, 
        secret_code: generate_secret, 
        parent: root, 
        panel_provider: panel_provider
      )
      leafs.each do |leaf_name|
        TargetGroup.create(
          name: leaf_name, 
          secret_code: generate_secret,
          parent: district, 
          panel_provider: panel_provider
        ) 
      end
    end
    panel_provider_index += 1
  end
end
