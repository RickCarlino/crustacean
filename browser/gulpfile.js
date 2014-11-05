var gulp = require('gulp'),
    plugin = require('gulp-load-plugins')({camelize:true});


// Paths
// =======================================================

var paths = {
  js: 'js/**/*.js',
  coffee: 'coffee/**/*.coffee',
  target: '../public'
};

// Coffee
// =======================================================

gulp.task('coffee', function() {
  gulp.src(paths.coffee)
    .pipe(plugin.coffee({}).on('error', plugin.util.log))
    .pipe(plugin.concat('browser.js'))
    .pipe(gulp.dest('js/'))
    .pipe(plugin.connect.reload());
});

// Copy into public
// =======================================================
gulp.task('publish', function(){
  gulp.src(['!node_modules/',
            '!node_modules/**',
            'js/**/*.js',
            './**/*.html',
            './**/*.css'], {base: "."})
    .pipe(gulp.dest('../public'))
});

// Server
// =======================================================

// gulp.task('connect', function() {
//   plugin.connect.server({
//     root: '.',
//     port: '8000',
//     livereload: true
//   });
// });

// Watch
// =======================================================

gulp.task('watch', ['compile'], function() {
  gulp.watch(paths.coffee, ['coffee']);
});

// Tasks
// =======================================================

gulp.task('default', ['watch'/*, 'connect'*/]);
gulp.task('compile', ['coffee', 'publish'])