.class public final Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$FunctionType;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FunctionType"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\n\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$FunctionType;",
        "",
        "()V",
        "ANIMATION",
        "",
        "AUTO_CHAT",
        "BASE_INFO_COMPLETE",
        "GLOBAL_RECORDING",
        "OFFLINE_MODE",
        "QRCODE_REC",
        "QRCODE_REC_END",
        "RESET_TASK_ID",
        "SHOW_CHAT",
        "TOAST",
        "sdk-base-common_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final ANIMATION:Ljava/lang/String; = "animation"

.field public static final AUTO_CHAT:Ljava/lang/String; = "autoChat"

.field public static final BASE_INFO_COMPLETE:Ljava/lang/String; = "baseInfoComplete"

.field public static final GLOBAL_RECORDING:Ljava/lang/String; = "globalRecording"

.field public static final INSTANCE:Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$FunctionType;

.field public static final OFFLINE_MODE:Ljava/lang/String; = "offline"

.field public static final QRCODE_REC:Ljava/lang/String; = "qrcode"

.field public static final QRCODE_REC_END:Ljava/lang/String; = "qrcodeRecEnd"

.field public static final RESET_TASK_ID:Ljava/lang/String; = "resetTaskId"

.field public static final SHOW_CHAT:Ljava/lang/String; = "showChat"

.field public static final TOAST:Ljava/lang/String; = "toast"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$FunctionType;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$FunctionType;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$FunctionType;->INSTANCE:Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$FunctionType;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
