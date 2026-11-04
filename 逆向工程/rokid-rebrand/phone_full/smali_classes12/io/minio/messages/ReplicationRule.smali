.class public Lio/minio/messages/ReplicationRule;
.super Ljava/lang/Object;
.source "ReplicationRule.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Rule"
.end annotation


# instance fields
.field private deleteMarkerReplication:Lio/minio/messages/DeleteMarkerReplication;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "DeleteMarkerReplication"
        required = false
    .end annotation
.end field

.field private deleteReplication:Lio/minio/messages/DeleteReplication;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "DeleteReplication"
        required = false
    .end annotation
.end field

.field private destination:Lio/minio/messages/ReplicationDestination;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Destination"
    .end annotation
.end field

.field private existingObjectReplication:Lio/minio/messages/ExistingObjectReplication;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ExistingObjectReplication"
        required = false
    .end annotation
.end field

.field private filter:Lio/minio/messages/RuleFilter;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Filter"
        required = false
    .end annotation
.end field

.field private id:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ID"
        required = false
    .end annotation
.end field

.field private prefix:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Prefix"
        required = false
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/convert/Convert;
        value = Lio/minio/messages/PrefixConverter;
    .end annotation
.end field

.field private priority:Ljava/lang/Integer;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Priority"
        required = false
    .end annotation
.end field

.field private sourceSelectionCriteria:Lio/minio/messages/SourceSelectionCriteria;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "SourceSelectionCriteria"
        required = false
    .end annotation
.end field

.field private status:Lio/minio/messages/Status;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/DeleteMarkerReplication;Lio/minio/messages/ReplicationDestination;Lio/minio/messages/ExistingObjectReplication;Lio/minio/messages/RuleFilter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Lio/minio/messages/SourceSelectionCriteria;Lio/minio/messages/DeleteReplication;Lio/minio/messages/Status;)V
    .locals 2
    .param p1, "deleteMarkerReplication"    # Lio/minio/messages/DeleteMarkerReplication;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "DeleteMarkerReplication"
            required = false
        .end annotation
    .end param
    .param p2, "destination"    # Lio/minio/messages/ReplicationDestination;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Destination"
        .end annotation
    .end param
    .param p3, "existingObjectReplication"    # Lio/minio/messages/ExistingObjectReplication;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ExistingObjectReplication"
            required = false
        .end annotation
    .end param
    .param p4, "filter"    # Lio/minio/messages/RuleFilter;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Filter"
            required = false
        .end annotation
    .end param
    .param p5, "id"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ID"
            required = false
        .end annotation
    .end param
    .param p6, "prefix"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Prefix"
            required = false
        .end annotation
    .end param
    .param p7, "priority"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Priority"
            required = false
        .end annotation
    .end param
    .param p8, "sourceSelectionCriteria"    # Lio/minio/messages/SourceSelectionCriteria;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "SourceSelectionCriteria"
            required = false
        .end annotation
    .end param
    .param p9, "deleteReplication"    # Lio/minio/messages/DeleteReplication;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "DeleteReplication"
            required = false
        .end annotation
    .end param
    .param p10, "status"    # Lio/minio/messages/Status;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Status"
        .end annotation
    .end param

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 79
    if-eqz p4, :cond_0

    if-nez p1, :cond_0

    .line 80
    new-instance v0, Lio/minio/messages/DeleteMarkerReplication;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lio/minio/messages/DeleteMarkerReplication;-><init>(Lio/minio/messages/Status;)V

    move-object p1, v0

    .line 83
    :cond_0
    if-eqz p5, :cond_3

    .line 84
    invoke-virtual {p5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p5

    .line 85
    invoke-virtual {p5}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 86
    invoke-virtual {p5}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xff

    if-gt v0, v1, :cond_1

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "ID must be exceed 255 characters"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 85
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "ID must be non-empty string"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 89
    :cond_3
    :goto_0
    iput-object p1, p0, Lio/minio/messages/ReplicationRule;->deleteMarkerReplication:Lio/minio/messages/DeleteMarkerReplication;

    .line 90
    const-string v0, "Destination must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ReplicationDestination;

    iput-object v0, p0, Lio/minio/messages/ReplicationRule;->destination:Lio/minio/messages/ReplicationDestination;

    .line 91
    iput-object p3, p0, Lio/minio/messages/ReplicationRule;->existingObjectReplication:Lio/minio/messages/ExistingObjectReplication;

    .line 92
    iput-object p4, p0, Lio/minio/messages/ReplicationRule;->filter:Lio/minio/messages/RuleFilter;

    .line 93
    iput-object p5, p0, Lio/minio/messages/ReplicationRule;->id:Ljava/lang/String;

    .line 94
    iput-object p6, p0, Lio/minio/messages/ReplicationRule;->prefix:Ljava/lang/String;

    .line 95
    iput-object p7, p0, Lio/minio/messages/ReplicationRule;->priority:Ljava/lang/Integer;

    .line 96
    iput-object p8, p0, Lio/minio/messages/ReplicationRule;->sourceSelectionCriteria:Lio/minio/messages/SourceSelectionCriteria;

    .line 97
    iput-object p9, p0, Lio/minio/messages/ReplicationRule;->deleteReplication:Lio/minio/messages/DeleteReplication;

    .line 98
    const-string v0, "Status must not be null"

    invoke-static {p10, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Status;

    iput-object v0, p0, Lio/minio/messages/ReplicationRule;->status:Lio/minio/messages/Status;

    .line 99
    return-void
.end method

.method public constructor <init>(Lio/minio/messages/DeleteMarkerReplication;Lio/minio/messages/ReplicationDestination;Lio/minio/messages/ExistingObjectReplication;Lio/minio/messages/RuleFilter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Lio/minio/messages/SourceSelectionCriteria;Lio/minio/messages/Status;)V
    .locals 11
    .param p1, "deleteMarkerReplication"    # Lio/minio/messages/DeleteMarkerReplication;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "DeleteMarkerReplication"
            required = false
        .end annotation
    .end param
    .param p2, "destination"    # Lio/minio/messages/ReplicationDestination;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Destination"
        .end annotation
    .end param
    .param p3, "existingObjectReplication"    # Lio/minio/messages/ExistingObjectReplication;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ExistingObjectReplication"
            required = false
        .end annotation
    .end param
    .param p4, "filter"    # Lio/minio/messages/RuleFilter;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Filter"
            required = false
        .end annotation
    .end param
    .param p5, "id"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ID"
            required = false
        .end annotation
    .end param
    .param p6, "prefix"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Prefix"
            required = false
        .end annotation
    .end param
    .param p7, "priority"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Priority"
            required = false
        .end annotation
    .end param
    .param p8, "sourceSelectionCriteria"    # Lio/minio/messages/SourceSelectionCriteria;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "SourceSelectionCriteria"
            required = false
        .end annotation
    .end param
    .param p9, "status"    # Lio/minio/messages/Status;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Status"
        .end annotation
    .end param

    .line 115
    const/4 v9, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    move-object/from16 v10, p9

    invoke-direct/range {v0 .. v10}, Lio/minio/messages/ReplicationRule;-><init>(Lio/minio/messages/DeleteMarkerReplication;Lio/minio/messages/ReplicationDestination;Lio/minio/messages/ExistingObjectReplication;Lio/minio/messages/RuleFilter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Lio/minio/messages/SourceSelectionCriteria;Lio/minio/messages/DeleteReplication;Lio/minio/messages/Status;)V

    .line 126
    return-void
.end method


# virtual methods
.method public deleteMarkerReplication()Lio/minio/messages/DeleteMarkerReplication;
    .locals 1

    .line 129
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->deleteMarkerReplication:Lio/minio/messages/DeleteMarkerReplication;

    return-object v0
.end method

.method public deleteReplication()Lio/minio/messages/DeleteReplication;
    .locals 1

    .line 161
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->deleteReplication:Lio/minio/messages/DeleteReplication;

    return-object v0
.end method

.method public destination()Lio/minio/messages/ReplicationDestination;
    .locals 1

    .line 133
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->destination:Lio/minio/messages/ReplicationDestination;

    return-object v0
.end method

.method public existingObjectReplication()Lio/minio/messages/ExistingObjectReplication;
    .locals 1

    .line 137
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->existingObjectReplication:Lio/minio/messages/ExistingObjectReplication;

    return-object v0
.end method

.method public filter()Lio/minio/messages/RuleFilter;
    .locals 1

    .line 141
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->filter:Lio/minio/messages/RuleFilter;

    return-object v0
.end method

.method public id()Ljava/lang/String;
    .locals 1

    .line 145
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->id:Ljava/lang/String;

    return-object v0
.end method

.method public prefix()Ljava/lang/String;
    .locals 1

    .line 149
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public priority()Ljava/lang/Integer;
    .locals 1

    .line 153
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->priority:Ljava/lang/Integer;

    return-object v0
.end method

.method public sourceSelectionCriteria()Lio/minio/messages/SourceSelectionCriteria;
    .locals 1

    .line 157
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->sourceSelectionCriteria:Lio/minio/messages/SourceSelectionCriteria;

    return-object v0
.end method

.method public status()Lio/minio/messages/Status;
    .locals 1

    .line 165
    iget-object v0, p0, Lio/minio/messages/ReplicationRule;->status:Lio/minio/messages/Status;

    return-object v0
.end method
