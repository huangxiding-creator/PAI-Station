.class public final enum Lio/minio/messages/Permission;
.super Ljava/lang/Enum;
.source "Permission.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/Permission;",
        ">;"
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Permission"
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/Permission;

.field public static final enum FULL_CONTROL:Lio/minio/messages/Permission;

.field public static final enum READ:Lio/minio/messages/Permission;

.field public static final enum READ_ACP:Lio/minio/messages/Permission;

.field public static final enum WRITE:Lio/minio/messages/Permission;

.field public static final enum WRITE_ACP:Lio/minio/messages/Permission;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/Permission;
    .locals 5

    .line 22
    sget-object v0, Lio/minio/messages/Permission;->FULL_CONTROL:Lio/minio/messages/Permission;

    sget-object v1, Lio/minio/messages/Permission;->WRITE:Lio/minio/messages/Permission;

    sget-object v2, Lio/minio/messages/Permission;->WRITE_ACP:Lio/minio/messages/Permission;

    sget-object v3, Lio/minio/messages/Permission;->READ:Lio/minio/messages/Permission;

    sget-object v4, Lio/minio/messages/Permission;->READ_ACP:Lio/minio/messages/Permission;

    filled-new-array {v0, v1, v2, v3, v4}, [Lio/minio/messages/Permission;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 24
    new-instance v0, Lio/minio/messages/Permission;

    const-string v1, "FULL_CONTROL"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/messages/Permission;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/Permission;->FULL_CONTROL:Lio/minio/messages/Permission;

    .line 25
    new-instance v0, Lio/minio/messages/Permission;

    const-string v1, "WRITE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/minio/messages/Permission;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/Permission;->WRITE:Lio/minio/messages/Permission;

    .line 26
    new-instance v0, Lio/minio/messages/Permission;

    const-string v1, "WRITE_ACP"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lio/minio/messages/Permission;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/Permission;->WRITE_ACP:Lio/minio/messages/Permission;

    .line 27
    new-instance v0, Lio/minio/messages/Permission;

    const-string v1, "READ"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lio/minio/messages/Permission;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/Permission;->READ:Lio/minio/messages/Permission;

    .line 28
    new-instance v0, Lio/minio/messages/Permission;

    const-string v1, "READ_ACP"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lio/minio/messages/Permission;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/Permission;->READ_ACP:Lio/minio/messages/Permission;

    .line 22
    invoke-static {}, Lio/minio/messages/Permission;->$values()[Lio/minio/messages/Permission;

    move-result-object v0

    sput-object v0, Lio/minio/messages/Permission;->$VALUES:[Lio/minio/messages/Permission;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 23
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/Permission;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 22
    const-class v0, Lio/minio/messages/Permission;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Permission;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/Permission;
    .locals 1

    .line 22
    sget-object v0, Lio/minio/messages/Permission;->$VALUES:[Lio/minio/messages/Permission;

    invoke-virtual {v0}, [Lio/minio/messages/Permission;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/Permission;

    return-object v0
.end method
