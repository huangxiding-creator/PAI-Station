.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/IdentificationAPI;
.super Ljava/lang/Object;
.source "IdentificationExtra.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;
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
        "Lcom/rokid/security/sdk/base/common/IdentificationAPI;",
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
.field public static final Companion:Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;

.field public static final end:Ljava/lang/String; = "end"

.field public static final execute:Ljava/lang/String; = "execute"

.field public static final mirrorError:Ljava/lang/String; = "mirrorError"

.field public static final mirrorImage:Ljava/lang/String; = "mirrorImage"

.field public static final mirrorModify:Ljava/lang/String; = "mirrorModify"

.field public static final mirrorQuestion:Ljava/lang/String; = "mirrorQuestion"

.field public static final mirrorResponse:Ljava/lang/String; = "mirrorResponse"

.field public static final modifyExecute:Ljava/lang/String; = "modifyExecute"

.field public static final onError:Ljava/lang/String; = "onError"

.field public static final onResponse:Ljava/lang/String; = "onResponse"

.field public static final stopTask:Ljava/lang/String; = "stopTask"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/IdentificationAPI;->Companion:Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;

    return-void
.end method
