import {makeScene2D} from '@motion-canvas/2d/lib/scenes';
import {createRef} from '@motion-canvas/core/lib/utils';
import {
  CodeBlock,
  edit,
  insert,
  lines,
  remove,
} from '@motion-canvas/2d/lib/components/CodeBlock';
import {all, waitFor} from '@motion-canvas/core/lib/flow';

export default makeScene2D(function* (view) {
  view.fill('#242424');
  const codeRef = createRef<CodeBlock>();

  yield view.add(<CodeBlock ref={codeRef} code={`System.out.println();`}   scale={[1, 1]}/>);

  yield* codeRef().edit(1.2, false)`System.out.println(${insert('"J\'étais développeur"')});`;
  yield* waitFor(0.6);
  yield* codeRef().edit(1.2,false)`System.out.println(${edit('"J\'étais développeur"', '"Je suis maintenant vidéaste"')});`;
  yield* waitFor(0.6);
 
}); 