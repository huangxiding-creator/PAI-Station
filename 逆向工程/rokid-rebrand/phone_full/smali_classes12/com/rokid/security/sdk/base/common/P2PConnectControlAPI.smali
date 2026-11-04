.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI;
.super Ljava/lang/Object;
.source "ConnectP2PRequestExtra.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;
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
        "Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI;",
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
.field public static final CONNECT_P2P_REQUEST:Ljava/lang/String; = "Connect_P2P_Request"

.field public static final CONNECT_P2P_RESPONSE:Ljava/lang/String; = "Connect_P2P_Response"

.field public static final Companion:Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;

.field public static final GET_KEEP_P2P_CONNECT_STATE_REQUEST:Ljava/lang/String; = "Get_Keep_P2P_Connect_State_Request"

.field public static final GET_KEEP_P2P_CONNECT_STATE_RESPONSE:Ljava/lang/String; = "Get_Keep_P2P_Connect_State_Response"

.field public static final SET_KEEP_P2P_CONNECT_REQUEST:Ljava/lang/String; = "Set_Keep_P2P_Connect_Request"

.field public static final SET_KEEP_P2P_CONNECT_RESPONSE:Ljava/lang/String; = "Set_Keep_P2P_Connect_Response"

.field public static final START_CONNECT_P2P:Ljava/lang/String; = "Start_Connect_P2P"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI;->Companion:Lcom/rokid/security/sdk/base/common/P2PConnectControlAPI$Companion;

    return-void
.end method
