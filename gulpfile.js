var gulp = require('gulp');
var less = require('gulp-less');
var slim = require("gulp-slim");
var coffee = require('gulp-coffee');
var cjsx = require('gulp-cjsx');
var plumber = require('gulp-plumber');
var del = require('del');

var paths = {
  coffee: ['./src/coffee/**/*.coffee'],
  slim: ['./src/slim/**/*.slim'],
  less: ['./src/less/**/*.less'],
  cjsx: ['./src/components/**/*.cjsx'],
};

gulp.task('clean', function(){});

gulp.task('coffee', ['clean'], function() {
  return gulp.src(paths.coffee)
    .pipe(plumber())
    .pipe(coffee())
    .pipe(gulp.dest('build/js'));
});

gulp.task('main', ['clean'], function() {
  return gulp.src('./main.coffee')
    .pipe(plumber())
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest('./build'));
});

gulp.task('slim', ['clean'], function(){
  return gulp.src(paths.slim)
    .pipe(plumber())
    .pipe(slim({
      pretty: true
    }))
    .pipe(gulp.dest("./build/html/"));
});

gulp.task('less', ['clean'], function () {
  return gulp.src(paths.less)
    .pipe(plumber())
    .pipe(less({
    }))
    .pipe(gulp.dest('./build/css'));
});

gulp.task('cjsx', ['clean'], function() {
  gulp.src(paths.cjsx)
    .pipe(plumber())
    .pipe(cjsx({ bare: true }))
    .pipe(gulp.dest('./build/components/'));
});

gulp.task('watch', function() {
  gulp.watch('./main.coffee', ['main']);
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.slim, ['slim']);
  gulp.watch(paths.less, ['less']);
  gulp.watch(paths.cjsx, ['cjsx']);
});

gulp.task('default', ['watch', 'coffee', 'slim', 'main', 'less', 'cjsx']);
