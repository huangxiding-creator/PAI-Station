.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/FileAPI;
.super Ljava/lang/Object;
.source "FileExtra.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/FileAPI$Companion;
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
        "Lcom/rokid/security/sdk/base/common/FileAPI;",
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
.field public static final CONNECT_SERVER_RECEIVE_FILE:Ljava/lang/String; = "connect_server_receive_file"

.field public static final Companion:Lcom/rokid/security/sdk/base/common/FileAPI$Companion;

.field public static final ON_CANCEL_RECEIVE_FILE:Ljava/lang/String; = "cancel_receive_file"

.field public static final ON_RECEIVE_FILE_COMPLETE:Ljava/lang/String; = "receive_file_complete"

.field public static final ON_RECEIVE_FILE_FAIL:Ljava/lang/String; = "receive_file_fail"

.field public static final ON_RECEIVE_PROGRESS_FILE:Ljava/lang/String; = "receive_progress_file"

.field public static final ON_START_RECEIVE_FILE:Ljava/lang/String; = "start_receive_file"

.field public static final READY_RECEIVE_FILE:Ljava/lang/String; = "ready_receive_file"

.field public static final READY_RECEIVE_FILE_RESPONSE:Ljava/lang/String; = "ready_receive_file_ok"

.field public static final SEND_FILE_METADATA:Ljava/lang/String; = "sendFileMetadata"

.field public static final STOP_SEND_FILE:Ljava/lang/String; = "stop_send_file"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/base/common/FileAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/FileAPI$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/FileAPI;->Companion:Lcom/rokid/security/sdk/base/common/FileAPI$Companion;

    return-void
.end method
