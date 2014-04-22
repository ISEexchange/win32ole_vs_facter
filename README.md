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

| Job | Duration | Finished       | Ruby  | ENV                                                             |
|-----|----------|----------------|-------|-----------------------------------------------------------------|
|8.1  | 51 sec   | 15 minutes ago | 2.0.0 | :checkered_flag: FACTER_VER='<= 1.7.2' SCRIPT='script/test'     |
|8.2  | 52 sec   | 15 minutes ago | 2.0.0 | :checkered_flag: FACTER_VER='<= 1.7.2' SCRIPT='script/mintest'  |
|8.3  | 55 sec   | 15 minutes ago | 2.0.0 | :checkered_flag: FACTER_VER='~> 2.0' SCRIPT='script/test'       |
|8.4  | 52 sec   | 15 minutes ago | 2.0.0 | :warning: FACTER_VER='~> 2.0' SCRIPT='script/mintest'           |
|14.5 | 3 min    | 15 minutes ago | 2.0.0 | :bangbang: FACTER_VER='bisect' SCRIPT='script/bisect'           |
|15.6 | 52 sec   | 15 minutes ago | 2.0.0 | :checkered_flag: FACTER_VER='~> 2.0' SCRIPT='script/mintest' PRESERVE=yes |

:bangbang: The fifth test runs `git-bisect` against upstream
[facter](https://github.com/puppetlabs/facter) project and
identifies the first bad commit as
https://github.com/puppetlabs/facter/commit/0a8c231b4269.
For a given travis build, you must drill down into job 5
to see the results.

The sixth test preserves facter cache between tests,
which makes the symptom go away.

ref: https://magnum.travis-ci.com/ISEexchange/win32ole_vs_facter/builds/


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
