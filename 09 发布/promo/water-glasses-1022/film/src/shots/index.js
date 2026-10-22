// 《发现隐患、预判风险》8 镜头 → 视图 + builder（镜头表见 DIRECTION.md §5）
import {OpenView, buildOpen} from './open.jsx';
import {ClaimsView, buildClaims} from './claims.jsx';
import {ScanView, buildScan} from './scan.jsx';
import {VerdictView, buildVerdict} from './verdict.jsx';
import {LoopView, buildLoop} from './loop.jsx';
import {HubView, buildHub} from './hub.jsx';
import {PredictView, buildPredict} from './predict.jsx';
import {CloseView, buildClose} from './close.jsx';

export const SHOT_VIEWS = {
  open: OpenView, claims: ClaimsView, scan: ScanView, verdict: VerdictView,
  loop: LoopView, hub: HubView, predict: PredictView, close: CloseView,
};
export const SHOT_BUILDERS = {
  buildOpen, buildClaims, buildScan, buildVerdict,
  buildLoop, buildHub, buildPredict, buildClose,
};
