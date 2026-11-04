.class public final Lcom/rokid/security/sdk/base/common/FileAPI$Companion;
.super Ljava/lang/Object;
.source "FileExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/FileAPI;
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
        "Lcom/rokid/security/sdk/base/common/FileAPI$Companion;",
        "",
        "()V",
        "CONNECT_SERVER_RECEIVE_FILE",
        "",
        "ON_CANCEL_RECEIVE_FILE",
        "ON_RECEIVE_FILE_COMPLETE",
        "ON_RECEIVE_FILE_FAIL",
        "ON_RECEIVE_PROGRESS_FILE",
        "ON_START_RECEIVE_FILE",
        "READY_RECEIVE_FILE",
        "READY_RECEIVE_FILE_RESPONSE",
        "SEND_FILE_METADATA",
        "STOP_SEND_FILE",
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
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/FileAPI$Companion;

.field public static final CONNECT_SERVER_RECEIVE_FILE:Ljava/lang/String; = "connect_server_receive_file"

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

    new-instance v0, Lcom/rokid/security/sdk/base/common/FileAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/FileAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/FileAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/FileAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
