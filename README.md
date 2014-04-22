win32ole_vs_facter
==================

Minimal puppet module to attempt reproducer for
https://github.com/ISEexchange/issue/issues/475

Travis fails due to a facter bug with LoadError:

```
1) win32ole_vs_facter::windows
   Failure/Error: it { should contain_notify('windows') }
   LoadError:
     cannot load such file -- win32ole
   # ./spec/classes/windows_spec.rb:10:in `block (2 levels) in <top (required)>'
```

Expect
------

Mock windows kernel should not impact rspec outcome.<br />
Given proper fixtures, there should be no difference in:

* `bundle exec rake spec`
* `bundle exec ruby -S rspec spec/classes/windows_spec.rb`

Actual
------

`rake spec` passes, but `ruby -S rspec spec/classes/windows_spec.rb` fails.

Build Matrix

| Job | Duration | Finished       | Ruby  | ENV                                            |
|-----|----------|----------------|-------|------------------------------------------------|
|8.1  | 51 sec   | 15 minutes ago | 2.0.0 | FACTER_VER='<= 1.7.2' SCRIPT='script/test'     |
|8.2  | 52 sec   | 15 minutes ago | 2.0.0 | FACTER_VER='<= 1.7.2' SCRIPT='script/mintest'  |
|8.3  | 55 sec   | 15 minutes ago | 2.0.0 | FACTER_VER='~> 2.0' SCRIPT='script/test'       |
|8.4  | 52 sec   | 15 minutes ago | 2.0.0 | FACTER_VER='~> 2.0' SCRIPT='script/mintest'    |


ref: https://magnum.travis-ci.com/ISEexchange/win32ole_vs_facter/builds/3483413


Simple module
-------------

For simplicity, the module classes are...

```
$ find . -regex '.*\.pp' -exec cat {} +
class win32ole_vs_facter {
  include "win32ole_vs_facter::${::kernel}"
}
class win32ole_vs_facter::windows {
  notify{'windows':}
}
class win32ole_vs_facter::linux {
  notify{'linux':}
}
```

...and the failing rspec is...

```
require 'spec_helper'

describe 'win32ole_vs_facter::windows' do
  let(:facts) do
    {
      kernel: 'windows'
    }
  end

  it { should contain_notify('windows') }
end
```

:warning: The rspec fails when mocking `:kernel => 'windows'`.<br />
This repo is a simple reproducer for a complex in-house puppet repo.
