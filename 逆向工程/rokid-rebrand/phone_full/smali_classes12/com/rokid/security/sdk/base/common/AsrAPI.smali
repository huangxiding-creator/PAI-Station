.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/AsrAPI;
.super Ljava/lang/Object;
.source "AsrExtra.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;
    }
.end annotation

.annotation runtime Ljava/lang/annotation/Retention;
    value = .enum Ljava/lang/annotation/RetentionPolicy;->SOURCE:Ljava/lang/annotation/RetentionPolicy;
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u001b\n\u0002\u0008\u0002\u0008\u0087\u0002\u0018\u0000 \u00022\u00020\u0001:\u0001\u0002B\u0000\u00a8\u0006\u0003"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/AsrAPI;",
        "",
        "Companion",
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

.annotation runtime Lkotlin/annotation/Retention;
    value = .enum Lkotlin/annotation/AnnotationRetention;->SOURCE:Lkotlin/annotation/AnnotationRetention;
.end annotation


# static fields
.field public static final Companion:Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;

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

    sget-object v0, Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/AsrAPI;->Companion:Lcom/rokid/security/sdk/base/common/AsrAPI$Companion;

    return-void
.end method
