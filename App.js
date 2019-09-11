/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Fragment} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  requireNativeComponent,
} from 'react-native';
const EditorView = requireNativeComponent('EditorView');

const App = () => {
  return (
    <SafeAreaView style={styles.container}>
      <EditorView style={styles.container} onImageChange={e => {
        console.log(e.nativeEvent.image);
      }}/>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
 container: {
   flex: 1,
   alignSelf: 'stretch',
 }
});

export default App;
