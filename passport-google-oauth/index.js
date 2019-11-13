const express = require('express');
const passport = require('passport');
const cookieParser = require('cookie-parser');
const cookieSession = require('cookie-session');


var app = express();
app.use(passport.initialize());
app.use(passport.session());
app.use(cookieSession({
  name: 'session',
  keys: ['SECRET_KEY']
}));
app.use(cookieParser());

var GoogleStrategy = require('passport-google-oauth20').Strategy;

const AUTH_CONFIG = {
  clientID: "1012227841684-g49dv1o04ah6ojce0hgoalhdhua822q8.apps.googleusercontent.com",
  clientSecret: "ZVJdkP1r6O1r1STLkMF7qOVG",
  callbackURL: "http://localhost:8082/auth/google/callback"
};
const PORT = 8082;
const HOST = '0.0.0.0';

passport.use(new GoogleStrategy(
  AUTH_CONFIG,
  function (accessToken, refreshToken, profile, cb) {

    console.log(profile);
    console.log(accessToken);
    console.log(refreshToken);

    return cb(null, profile);
  }
));

passport.serializeUser((user, cb) => {
  console.log('oauth2.js: serializeUser', user);
  cb(null, user);
});
passport.deserializeUser((obj, cb) => {
  console.log('oauth2.js: deserializeUser', obj);
  cb(null, obj);
});

app.get('/auth/google',
  passport.authenticate('google', {
    session: false,
    scope: ['profile']
  }));

app.get('/auth/google/callback',
  passport.authenticate('google', {
    failureRedirect: '/'
  }),
  (req, res) => {
    req.session.token = req.user.token;
    res.redirect('/');
  });

app.get('/',
  function (req, res) {
    console.log(req.user);

    if (req.session.token) {
      res.cookie('token', req.session.token);
      res.json({
        status: 'session cookie set'
      });
    } else {
      res.cookie('token', '')
      res.json({
        status: 'session cookie not set'
      });
    }

    // if (req.isAuthenticated())
    //   res.json('authenticated: TRUE');
    // else {
    //   res.send('authenticated: FALSE <a href="/auth/google">Login</a>');
    // }
  });

app.get('/logout', (req, res) => {
  req.logout();
  req.session = null;
  res.redirect('/');
});

app.get('/:user',
  function (req, res) {
    res.send(`User: ${req.params.user} <a href="/auth/google">Login</a>`)
  });


app.listen(PORT, HOST);