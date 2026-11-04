.class public final Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;
.super Ljava/lang/Object;
.source "AsrExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/AsrAPI;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\n\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;",
        "",
        "()V",
        "connectState",
        "",
        "destroy",
        "doSpeechVoice",
        "initAsr",
        "onAsrComplete",
        "onError",
        "onIntermediateVad",
        "onStart",
        "startSpeech",
        "stopSpeech",
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
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;

.field public static final connectState:Ljava/lang/String; = "connectState"

.field public static final destroy:Ljava/lang/String; = "destroy"

.field public static final doSpeechVoice:Ljava/lang/String; = "doSpeechVoice"

.field public static final initAsr:Ljava/lang/String; = "initAsr"

.field public static final onAsrComplete:Ljava/lang/String; = "onAsrComplete"

.field public static final onError:Ljava/lang/String; = "onError"

.field public static final onIntermediateVad:Ljava/lang/String; = "onIntermediateVad"

.field public static final onStart:Ljava/lang/String; = "onStart"

.field public static final startSpeech:Ljava/lang/String; = "startSpeech"

.field public static final stopSpeech:Ljava/lang/String; = "stopSpeech"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
