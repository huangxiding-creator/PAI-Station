.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/TranslateAPI;
.super Ljava/lang/Object;
.source "TranslateExtra.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/TranslateAPI$Companion;
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
        "Lcom/rokid/security/sdk/base/common/TranslateAPI;",
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
.field public static final Companion:Lcom/rokid/security/sdk/base/common/TranslateAPI$Companion;

.field public static final connectState:Ljava/lang/String; = "connectState"

.field public static final destroy:Ljava/lang/String; = "destroy"

.field public static final init:Ljava/lang/String; = "init"

.field public static final onEnd:Ljava/lang/String; = "onEnd"

.field public static final onFinalTranslate:Ljava/lang/String; = "onFinalTranslate"

.field public static final onStart:Ljava/lang/String; = "onStart"

.field public static final onTranslate:Ljava/lang/String; = "onTranslate"

.field public static final startTranslate:Ljava/lang/String; = "startTranslate"

.field public static final stopTranslate:Ljava/lang/String; = "stopTranslate"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/base/common/TranslateAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/TranslateAPI$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/TranslateAPI;->Companion:Lcom/rokid/security/sdk/base/common/TranslateAPI$Companion;

    return-void
.end method
