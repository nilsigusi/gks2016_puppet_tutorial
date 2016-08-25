Facter.add('complex') do # same as filename
  setcode do
    complex = Facter.value(:operatingsystem) + " " + Facter.value(:operatingsystemmajrelease) + " " + Facter.value(:operatingsystemrelease)
    complex
  end
end
