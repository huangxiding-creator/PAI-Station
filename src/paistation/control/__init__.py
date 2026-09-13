"""机器控制面包（Phase C，P1 支柱）：本机网关+风控信任+审批密码学+账本+旋钮。"""
from .approval import ApprovalLog, build_approval, verify_approval
from .gateway import Gateway, execution_log
from .knob import intervention_interval
from .meter import Meter, usage
from .policy import Action, Policy
from .registry import ActionSpec, Registry

__all__ = ["Action", "ActionSpec", "ApprovalLog", "Gateway", "Meter",
           "Policy", "Registry", "build_approval", "execution_log",
           "intervention_interval", "usage", "verify_approval"]
