.class public Lio/minio/messages/Grantee;
.super Ljava/lang/Object;
.source "Grantee.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Grantee"
.end annotation


# instance fields
.field private displayName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "DisplayName"
        required = false
    .end annotation
.end field

.field private emailAddress:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "EmailAddress"
        required = false
    .end annotation
.end field

.field private id:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ID"
        required = false
    .end annotation
.end field

.field private type:Lio/minio/messages/GranteeType;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Type"
    .end annotation
.end field

.field private uri:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "URI"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/GranteeType;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "type"    # Lio/minio/messages/GranteeType;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "displayName"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p3, "emailAddress"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p4, "id"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p5, "uri"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 52
    const-string v0, "Type must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/GranteeType;

    iput-object v0, p0, Lio/minio/messages/Grantee;->type:Lio/minio/messages/GranteeType;

    .line 53
    iput-object p2, p0, Lio/minio/messages/Grantee;->displayName:Ljava/lang/String;

    .line 54
    iput-object p3, p0, Lio/minio/messages/Grantee;->emailAddress:Ljava/lang/String;

    .line 55
    iput-object p4, p0, Lio/minio/messages/Grantee;->id:Ljava/lang/String;

    .line 56
    iput-object p5, p0, Lio/minio/messages/Grantee;->uri:Ljava/lang/String;

    .line 57
    return-void
.end method
