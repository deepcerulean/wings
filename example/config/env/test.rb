### any config needed for the test environment
# don't connect to a view adapter

#puts "==================================== TEST MODE ==========================================="
puts
puts
print '*' * 40
print ' WINGS (TEST MODE) '
puts '*' * 40
puts '=== USING NO-OP VIEW ENGINE ==='

Wings.view_engine = Wings::Engines::NoopViewEngine

