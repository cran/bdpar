context("FindEmojiPipe")

test_that("initialize",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()

  expect_silent(FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps))
})

test_that("initialize propertyName type error",{

  propertyName <- NULL
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()

  expect_error(FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps),"\\[FindEmojiPipe\\]\\[initialize\\]\\[Error\\]
                Checking the type of the variable: propertyName NULL")
})

test_that("initialize alwaysBeforeDeps type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- NULL
  notAfterDeps <- list()

  expect_error(FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps),"\\[FindEmojiPipe\\]\\[initialize\\]\\[Error\\]
                Checking the type of the variable: alwaysBeforeDeps NULL")
})

test_that("initialize notAfterDeps type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- NULL

  expect_error(FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps),"\\[FindEmojiPipe\\]\\[initialize\\]\\[Error\\]
                Checking the type of the variable: notAfterDeps NULL")

})

test_that("pipe removeEmoji <- TRUE",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  path <- system.file(file.path("testFiles","_ham_",
                                "30.tsms"),
                      package = "bdpar")

  instance <- ExtractorSms$new(path)
  instance$setData("Hey I am \U0001f600")
  removeEmoji <- TRUE
  instance <- pipe$pipe(instance, removeEmoji)
  expect_equal(instance$getSpecificProperty("Emojis"),"\U0001f600")
  expect_equal(instance$getData(),"Hey I am  grinning face")

})

test_that("pipe removeEmoji <- FALSE",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  path <- system.file(file.path("testFiles","_ham_",
                                "30.tsms"),
                      package = "bdpar")

  instance <- ExtractorSms$new(path)
  instance$setData("Hey I am \U0001f600")
  removeEmoji <- FALSE
  instance <- pipe$pipe(instance, removeEmoji)
  expect_equal(instance$getSpecificProperty("Emojis"),"\U0001f600")
  expect_equal(instance$getData(),"Hey I am \U0001f600")

})

test_that("pipe Bad compatibility between Pipes.",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list("pipeExample")
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  path <- system.file(file.path("testFiles","_ham_",
                                "30.tsms"),
                      package = "bdpar")

  instance <- ExtractorSms$new(path)
  instance$addBanPipes("pipeExample")
  instance$setData("Hey I am \U0001f600")
  removeEmoji <- TRUE
  expect_error(pipe$pipe(instance, removeEmoji),"\\[FindEmojiPipe\\]\\[pipe\\]\\[Error\\] Bad compatibility between Pipes.")

})

test_that("pipe instance type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  instance <- NULL
  removeEmoji <- TRUE
  expect_error(pipe$pipe(instance, removeEmoji),"\\[FindEmojiPipe\\]\\[pipe\\]\\[Error\\]
                Checking the type of the variable: instance NULL")

})

test_that("pipe removeEmoji type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  path <- system.file(file.path("testFiles","_ham_",
                                "30.tsms"),
                      package = "bdpar")

  instance <- ExtractorSms$new(path)
  instance$setData("Hey I am \U0001f600")
  removeEmoji <- NULL
  expect_error(pipe$pipe(instance, removeEmoji),"\\[FindEmojiPipe\\]\\[pipe\\]\\[Error\\]
                Checking the type of the variable: replaceEmoji NULL")

})

test_that("findEmoji",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  data <- "\U0001f600"
  emoji <- "\U0001f600"
  expect_equal(pipe$findEmoji(data, emoji),TRUE)

})

test_that("findEmoji data type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  data <- NULL
  emoji <- "\U0001f600"
  expect_error(pipe$findEmoji(data, emoji),"\\[FindEmojiPipe\\]\\[findEmoji\\]\\[Error\\]
                Checking the type of the variable: data NULL")

})

test_that("findEmoji emoji type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  data <- "\U0001f600"
  emoji <- NULL
  expect_error(pipe$findEmoji(data, emoji),"\\[FindEmojiPipe\\]\\[findEmoji\\]\\[Error\\]
                Checking the type of the variable: emoji NULL")

})

test_that("replaceEmoji",{

  propertyName <- "emoticon"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  emoji <- "\U0001f600"
  extendedEmoji <- "grinning face"
  data <- "\U0001f600"

  expect_equal(pipe$replaceEmoji(emoji, extendedEmoji, data)," grinning face ")

})

test_that("replaceEmoji emoji type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  emoji <- NULL
  extendedEmoji <- "grinning face"
  data <- "\U0001f600"

  expect_error(pipe$replaceEmoji(emoji, extendedEmoji, data),"\\[FindEmojiPipe\\]\\[replaceEmoji\\]\\[Error\\]
                Checking the type of the variable: emoji NULL")

})

test_that("replaceEmoji extendedEmoji type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)


  emoji <- "\U0001f600"
  extendedEmoji <- NULL
  data <- "\U0001f600"

  expect_error(pipe$replaceEmoji(emoji, extendedEmoji, data),"\\[FindEmojiPipe\\]\\[replaceEmoji\\]\\[Error\\]
                Checking the type of the variable: extendedEmoji NULL")

})

test_that("replaceEmoji data type error",{

  propertyName <- "Emojis"
  alwaysBeforeDeps <- list()
  notAfterDeps <- list()
  pipe <- FindEmojiPipe$new(propertyName, alwaysBeforeDeps, notAfterDeps)

  emoji <- "\U0001f600"
  extendedEmoji <-  "grinning face"
  data <- NULL

  expect_error(pipe$replaceEmoji(emoji, extendedEmoji, data),"\\[FindEmojiPipe\\]\\[replaceEmoji\\]\\[Error\\]
                Checking the type of the variable: data NULL")

})