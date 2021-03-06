testthat::context("ExtractorFactory")

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("initialize",{
  testthat::expect_silent(ExtractorFactory$new())
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("createInstance NULL",{
  factory <- ExtractorFactory$new()
  testthat::expect_warning(factory$createInstance("example.exa"),
                           "[ExtractorFactory][createInstance][WARN] The extension 'exa' is not registered",
                           fixed = TRUE)
  testthat::expect_null(suppressWarnings(factory$createInstance("example.exa")))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("createInstance path type error",{
  path <- NULL
  testthat::expect_error(ExtractorFactory$new()$createInstance(path),
                         "[ExtractorFactory][createInstance][FATAL] Checking the type of the 'path' variable: NULL",
                         fixed = TRUE)
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("createInstance tsms",{
  factory <- ExtractorFactory$new()

  testthat::expect_equal(class(factory$createInstance("example.tsms")),
                         c("ExtractorSms","Instance","R6"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("createInstance eml",{
  factory <- ExtractorFactory$new()
  testthat::expect_equal(class(factory$createInstance("example.eml")),
                         c("ExtractorEml","Instance","R6"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("createInstance default",{
  factory <- ExtractorFactory$new()
  testthat::expect_invisible(factory$setDefaultExtractor(ExtractorSms))
  testthat::expect_equal(class(factory$createInstance("example.sms")),
                         c("ExtractorSms","Instance","R6"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("getAllExtractors",{
  extractors <- ExtractorFactory$new()
  testthat::expect_type(extractors$getAllExtractors(),"list")
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("registerExtractor",{
  extractors <- ExtractorFactory$new()
  testthat::expect_invisible(extractors$registerExtractor("json", ExtractorEml))
  testthat::expect_true(extractors$isSpecificExtractor("json"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("registerExtractor set default extractor",{
  extractors <- ExtractorFactory$new()
  testthat::expect_invisible(extractors$setDefaultExtractor(ExtractorSms))
  testthat::expect_equal(extractors$getDefaultExtractor()$classname,
                        "ExtractorSms")

  testthat::expect_invisible(extractors$setDefaultExtractor(NULL))
  testthat::expect_null(extractors$getDefaultExtractor())
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("registerExtractor error set default extractor",{
  extractors <- ExtractorFactory$new()
  testthat::expect_error(extractors$setDefaultExtractor(ExtractorFactory),
                         "[ExtractorFactory][setDefaultExtractor][FATAL] Checking the type of the 'defaultExtractor' variable: R6ClassGenerator",
                         fixed = TRUE)
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("registerExtractor severals extensions",{
  extractors <- ExtractorFactory$new()
  testthat::expect_invisible(extractors$registerExtractor(c("emlExample1", "emlExample2"), ExtractorEml))
  testthat::expect_true(extractors$isSpecificExtractor("emlExample1"))
  testthat::expect_true(extractors$isSpecificExtractor("emlExample2"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("registerExtractor fails several extensions",{
  extractors <- ExtractorFactory$new()
  testthat::expect_true(extractors$isSpecificExtractor("eml"))
  testthat::expect_error(extractors$registerExtractor(c("emlExample1", "eml"), ExtractorEml),
                         "[ExtractorFactory][registerExtractor][FATAL] 'eml' extension is already added",
                         fixed = TRUE)
  testthat::expect_false(extractors$isSpecificExtractor("emlExample1"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("registerExtractor type error",{
  extractors <- ExtractorFactory$new()
  testthat::expect_error(extractors$registerExtractor(1, 1),
                         "[ExtractorFactory][registerExtractor][FATAL] Checking the type of the 'extensions' variable: numeric",
                         fixed = TRUE)

  testthat::expect_error(extractors$registerExtractor("json", 2),
                         "[ExtractorFactory][registerExtractor][FATAL] Checking the type of the 'extractor' variable: numeric",
                         fixed = TRUE)

  testthat::expect_error(extractors$registerExtractor("eml", ExtractorEml),
                         "[ExtractorFactory][registerExtractor][FATAL] 'eml' extension is already added",
                         fixed = TRUE)
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("setExtractor",{
  extractors <- ExtractorFactory$new()
  testthat::expect_invisible(extractors$setExtractor("tsms", ExtractorSms))
  testthat::expect_true(extractors$isSpecificExtractor("tsms"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("setExtractor type error",{
  extractors <- ExtractorFactory$new()
  testthat::expect_error(extractors$setExtractor(1, 1),
                         "[ExtractorFactory][setExtractor][FATAL] Checking the type of the 'extension' variable: numeric",
                         fixed = TRUE)

  testthat::expect_error(extractors$setExtractor("json", 2),
                         "[ExtractorFactory][setExtractor][FATAL] 'json' extension is not configured",
                         fixed = TRUE)

  testthat::expect_error(extractors$setExtractor("eml", 2),
                         "[ExtractorFactory][setExtractor][FATAL] Checking the type of the 'extractor' variable: numeric",
                         fixed = TRUE)
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("remove",{
  extractors <- ExtractorFactory$new()
  testthat::expect_invisible(extractors$removeExtractor("tsms"))
  testthat::expect_false(extractors$isSpecificExtractor("tsms"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("remove type error",{
  extractors <- ExtractorFactory$new()
  testthat::expect_error(extractors$removeExtractor(1),
                         "[ExtractorFactory][removeExtractor][FATAL] Checking the type of the 'extension' variable: numeric",
                         fixed = TRUE)
  testthat::expect_error(extractors$removeExtractor("a"),
                         "[ExtractorFactory][removeExtractor][FATAL] 'a' extension is not configured",
                         fixed = TRUE)
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("getDefaultExtractor",{
  extractors <- ExtractorFactory$new()
  testthat::expect_null(extractors$getDefaultExtractor())
  testthat::expect_invisible(extractors$setDefaultExtractor(ExtractorSms))
  testthat::expect_equal(extractors$getDefaultExtractor()$classname,
                        "ExtractorSms")
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("isSpecificExtractor",{
  extractors <- ExtractorFactory$new()
  testthat::expect_true(extractors$isSpecificExtractor("tsms"))
  testthat::expect_false(extractors$isSpecificExtractor("wrong"))
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("reset",{
  extractors <- ExtractorFactory$new()

  all <- extractors$getAllExtractors()
  extractors$registerExtractor("json", ExtractorEml)
  testthat::expect_invisible(extractors$reset())
  testthat::expect_equal(extractors$getAllExtractors(), all)
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::setup({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})

testthat::test_that("print",{
  extractors <- ExtractorFactory$new()
  testthat::expect_output(print(extractors), "[A-Za-z0-9$/.]+")
})

testthat::teardown({
  bdpar.Options$reset()
  bdpar.Options$configureLog()
})
