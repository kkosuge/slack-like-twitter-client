var gulp = require('gulp');
var less = require('gulp-less');
var stylus = require('gulp-stylus');
var jade = require("gulp-jade");
var coffee = require('gulp-coffee');
var cjsx = require('gulp-cjsx');
var plumber = require('gulp-plumber');
var jade = require("gulp-jade")
var del = require('del');

var paths = {
  coffee: ['./src/**/*.coffee'],
  jade: ['./src/**/*.jade'],
  less: ['./src/**/*.less'],
  stylus: ['./src/**/*.styl'],
  cjsx: ['./src/**/*.cjsx'],
};

gulp.task('clean', function(){});

gulp.task('coffee', ['clean'], function() {
  return gulp.src(paths.coffee)
    .pipe(plumber())
    .pipe(coffee())
    .pipe(gulp.dest('build'));
});

gulp.task('main', ['clean'], function() {
  return gulp.src('./main.coffee')
    .pipe(plumber())
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest('build'));
});

gulp.task('jade', ['clean'], function(){
  return gulp.src(paths.jade)
    .pipe(plumber())
    .pipe(jade({
      pretty: true
    }))
    .pipe(gulp.dest('build'));
});

gulp.task('less', ['clean'], function () {
  return gulp.src(paths.less)
    .pipe(plumber())
    .pipe(less({
    }))
    .pipe(gulp.dest('build'));
});

gulp.task('stylus', ['clean'], function () {
  return gulp.src(paths.stylus)
    .pipe(plumber())
    .pipe(stylus({
    }))
    .pipe(gulp.dest('build'));
});


gulp.task('cjsx', ['clean'], function() {
  gulp.src(paths.cjsx)
    .pipe(plumber())
    .pipe(cjsx({ bare: true }))
    .pipe(gulp.dest('build'));
});

gulp.task('watch', function() {
  gulp.watch('./main.coffee', ['main']);
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.jade, ['jade']);
  gulp.watch(paths.less, ['less']);
  gulp.watch(paths.stylus, ['stylus']);
  gulp.watch(paths.cjsx, ['cjsx']);
});

gulp.task('default', ['watch', 'coffee', 'jade', 'main', 'less', 'cjsx', 'stylus']);
