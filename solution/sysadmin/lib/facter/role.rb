Facter.add('role') do
  setcode do
    Facter::Core::Execution.exec('cat /etc/role')
  end
end
