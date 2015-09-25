require 'test/unit/ui/console/testrunner'
require 'test/unit'
require 'appium_lib'

class TC_EXAMPLE < Test::Unit::TestCase

  # Patch to your file
  APP_PATCH = '../Apk/com.whatsapp.app.apk'

  # Execute this before every test case.
  def setup
    caps = {
        caps: {
            platformName: 'Android',
            platformVersion: '5.0',
            deviceName: 'Android Emulator',
            app: APP_PATCH,
            name: 'Ruby Appium Android example'
        },
        appium_lib: {
            sauce_username: nil,
            sauce_access_key: nil
        }
    }
    driver = Appium::Driver.new(caps)
    Appium.promote_appium_methods self.class
    driver.start_driver.manage.timeouts.implicit_wait = 20 # seconds
  end

  # Execute this after every test case.
  def teardown
    driver_quit
  end

  def test_empty
    # Empty.
  end

  def test_file_exists_pass
    assert(test(?e, __FILE__), "** ERROR:  The file is missing")
  end

  def abort_test!
    throw 'abort_test!'
  end

  def self.abortable m
    m, m2 = '#{ m }', '__#{ m }__'
    alias_method m2, m
    define_method(m) { |*a| catch('abort_test!') { send(m2, *a) } }
  end

  instance_methods.each { |m| abortable m if m =~ %r/^test/ }

end # TC_EXAMPLE < Test::Unit::TestCase

puts "== beginning the tests"
Test::Unit::UI::Console::TestRunner.run(TC_EXAMPLE)
puts "== finished the tests"