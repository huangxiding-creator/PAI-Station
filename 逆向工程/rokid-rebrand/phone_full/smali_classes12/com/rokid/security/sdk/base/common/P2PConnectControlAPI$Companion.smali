.class public final Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;
.super Ljava/lang/Object;
.source "ConnectP2PRequestExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0007\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;",
        "",
        "()V",
        "CONNECT_P2P_REQUEST",
        "",
        "CONNECT_P2P_RESPONSE",
        "GET_KEEP_P2P_CONNECT_STATE_REQUEST",
        "GET_KEEP_P2P_CONNECT_STATE_RESPONSE",
        "SET_KEEP_P2P_CONNECT_REQUEST",
        "SET_KEEP_P2P_CONNECT_RESPONSE",
        "START_CONNECT_P2P",
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
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;

.field public static final CONNECT_P2P_REQUEST:Ljava/lang/String; = "Connect_P2P_Request"

.field public static final CONNECT_P2P_RESPONSE:Ljava/lang/String; = "Connect_P2P_Response"

.field public static final GET_KEEP_P2P_CONNECT_STATE_REQUEST:Ljava/lang/String; = "Get_Keep_P2P_Connect_State_Request"

.field public static final GET_KEEP_P2P_CONNECT_STATE_RESPONSE:Ljava/lang/String; = "Get_Keep_P2P_Connect_State_Response"

.field public static final SET_KEEP_P2P_CONNECT_REQUEST:Ljava/lang/String; = "Set_Keep_P2P_Connect_Request"

.field public static final SET_KEEP_P2P_CONNECT_RESPONSE:Ljava/lang/String; = "Set_Keep_P2P_Connect_Response"

.field public static final START_CONNECT_P2P:Ljava/lang/String; = "Start_Connect_P2P"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
